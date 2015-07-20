module Stellar
  module Util

    require 'base32'
    require 'digest/crc16_xmodem'

    class StrKey

      VERSION_BYTES = {
        account_id: [ 6 << 3].pack("C"), # Base32-encodes to 'G...'
        seed:       [18 << 3].pack("C"), # Base32-encodes to 'S...'
      }

      def self.check_encode(version, byte_str)
        version_byte = VERSION_BYTES[version]
        raise ArgumentError, "Invalid version: #{version}" if version_byte.blank?
        payload = version_byte + byte_str.dup.force_encoding("BINARY")
        check   = checksum(payload)
        Base32.encode(payload + check)
      end

      def self.check_decode(expected_version, str)
        decoded      = Base32.decode(str) rescue (raise ArgumentError, "Invalid base32 string")
        version_byte = decoded[0]
        payload      = decoded[1...-2]
        check        = decoded[-2..-1]
        version      = VERSION_BYTES.key(version_byte)

        raise ArgumentError, "Unexpected version: #{version.inspect}" if version != expected_version
        raise ArgumentError, "Invalid checksum" if check != checksum(decoded[0...-2])
        payload
      end

      # return the "XModem CRC16" (CCITT-like, but with 0-init and MSB first)
      # packed into a string in little-endian order
      def self.checksum(bytes)
        crc = Digest::CRC16XModem.checksum(bytes)
        [crc].pack("S<")
      end

    end
  end
end
