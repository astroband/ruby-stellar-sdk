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
        muxed: [12 << 3].pack("C") # Base32-encodes to 'M...'
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

      # Converts an Stellar::MuxedAccount to its string representation, forcing the ed25519 representation.
      # @param muxed_account [Stellar::MuxedAccount] account
      # @return [String] "G.."-like address
      def self.encode_muxed_account(muxed_account)
        if muxed_account.ed25519
          check_encode(:account_id, muxed_account.ed25519)
        else
          check_encode(:muxed, muxed_account.med25519!.ed25519 + [muxed_account.med25519!.id].pack("Q>"))
        end
      end

      # Returns a Stellar::MuxedAccount, forcing the ed25519 discriminant
      #
      # @param strkey [String] address string to decode
      # @return [Stellar::MuxedAccount] MuxedAccount with ed25519 discriminant
      def self.decode_muxed_account(strkey)
        case strkey
        when /^G[0-9A-Z]{55}$/
          ed25519 = check_decode(:account_id, strkey)
          Stellar::MuxedAccount.ed25519(ed25519)
        when /^M[0-9A-Z]{68}$/
          payload = check_decode(:muxed, strkey)
          Stellar::MuxedAccount.med25519(ed25519: payload[0, 32], id: payload[32, 8].unpack1("Q>"))
        else
          raise "cannot decode MuxedAccount from #{strkey}"
        end
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
