module Stellar
  module Util
    require "base32"
    require "digest/crc16_xmodem"

    class StrKey
      VERSION_BYTES = {
        account_id: [6 << 3].pack("C"), # Base32-encodes to 'G...'
        seed: [18 << 3].pack("C"), # Base32-encodes to 'S...'
        pre_auth_tx: [19 << 3].pack("C"), # Base32-encodes to 'T...'
        hash_x: [23 << 3].pack("C"), # Base32-encodes to 'X...'
        muxed_account: [12 << 3].pack("C") # Base32-encodes to 'M...'
      }

      def self.check_encode(version, byte_str)
        version_byte = VERSION_BYTES[version]
        raise ArgumentError, "Invalid version: #{version}" if version_byte.blank?
        payload = version_byte + byte_str.dup.force_encoding("BINARY")
        check = checksum(payload)
        # TODO: sort out, is it 100% safe to remove padding
        # SEP-23 says yes, but shit happens
        Base32.encode(payload + check).tr("=", "")
      end

      def self.encode_muxed_account(data)
        muxed = Stellar::MuxedAccount.from_xdr(data)

        if muxed.switch == Stellar::CryptoKeyType.key_type_ed25519
          return check_encode(:account_id, muxed.ed25519)
        end

        check_encode(:muxed_account, muxed.med25519!.to_xdr)
      end

      def self.decode_muxed_account(strkey)
        muxed = case strkey.size
        when 56
          Stellar::MuxedAccount.new(:key_type_ed25519, check_decode(:account_id, strkey))
        when 69
          med25519 = Stellar::MuxedAccount::Med25519.from_xdr(
            check_decode(:muxed_account, strkey)
          )
          Stellar::MuxedAccount.new(:key_type_muxed_ed25519, med25519)
        else
          raise ArgumentError, "invalid encoded string"
        end

        muxed.to_xdr
      end

      def self.check_decode(expected_version, str)
        decoded = begin
                    Base32.decode(str)
                  rescue
                    raise ArgumentError, "Invalid base32 string"
                  end
        version_byte = decoded[0]
        payload = decoded[1...-2]
        check = decoded[-2..-1]
        version = VERSION_BYTES.key(version_byte)

        raise ArgumentError, "invalid encoded string" if str != Base32.encode(decoded).tr("=", "")
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
