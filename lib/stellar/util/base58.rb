module Stellar
  module Util
    class Base58
      STELLAR_ALPHABET = "gsphnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCr65jkm8oFqi1tuvAxyz"
      BITCOIN_ALPHABET = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
      BASE             = 58

      # TODO: improve the conversion to bitstring, perhaps `Fixnum#to_byte`?
      VERSION_BYTES = {
        none:       [1].pack("C"),
        account_id: [0].pack("C"),
        seed:       [33].pack("C"),
      }

      def initialize(alphabet)
        raise ArgumentError, "Invalid alphabet length" if alphabet.length != BASE
        @alphabet = alphabet
      end

      def encode(byte_str)
        return "" if byte_str.nil? || byte_str.empty?

        leading_zeros = byte_str.each_byte.take_while{|b| b == 0}.length
        int           = bytes_to_int(byte_str) # step 1

        encode_int(int, leading_zeros)
      end

      def check_encode(version, byte_str)
        version_byte = VERSION_BYTES[version]
        raise ArgumentError, "Invalid version: #{version}" if version_byte.blank?

        payload = version_byte + byte_str
        check   = checksum(payload)
        encode(payload + check)
      end

      def decode(str)
        leading_zeros = str.each_char.take_while{|c| c == @alphabet[0]}.length

        ("\x00" * leading_zeros) + decode_int(str)
      end

      def check_decode(expected_version, str)
        decoded      = decode(str)
        version_byte = decoded[0]
        payload      = decoded[1...-4]
        check        = decoded[-4..-1]
        version      = VERSION_BYTES.key(version_byte)

        raise ArgumentError, "Unexpected version: #{version.inspect}" if version != expected_version
        raise ArgumentError, "Invalid checksum" if check != checksum(decoded[0...-4])
        payload
      end

      def checksum(bytes)
        inner = Digest::SHA256.digest(bytes)
        Digest::SHA256.digest(inner)[0...4]
      end

      private
      def encode_int(int, leading_zeros=0)
        # algorithm:
        # 1. convert the bytes to a bignum
        # 2. turn the bignum into a array of digits, least significant first
        # 3. add any leading zero bytes as leading 0 digits
        # 4. alphabatize the digits based upon the chosen alphabet
        # 5. reverse the alphabetized digits (to get most significant digit first)

        digits = []

        # step 2
        while int > 0
          int, rem = int.divmod(BASE)
          digits.push rem
        end

        # step 3
        leading_zeros.times{ digits.push 0 }

        digits
          .map{|d| @alphabet[d]} # step 4
          .reverse # step 5
          .join
      end

      def decode_int(str)
        int = str.reverse.each_char.with_index.inject(0) do |result, (digit, index)|
                digit_val = @alphabet.index(digit)
                raise ArgumentError, "#{digit} is not a valid base58 digit" if digit_val.nil?
                result + (digit_val * (BASE**index))
              end

        int_to_bytes(int)
      end

      def bytes_to_int(bytes)
        bytes.unpack("C*").inject do |result, byte|
          result <<= 8
          result + byte
        end
      end

      def int_to_bytes(int)
        return "\x00" if int == 0

        bytes   = []
        current = int

        while current > 0
          bytes.unshift(current & 0xFF)
          current >>= 8
        end

        bytes.pack("C*")
      end
    end
  end
end