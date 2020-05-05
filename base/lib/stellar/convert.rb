module Stellar
  #
  # Generic format conversion module
  #
  module Convert
    require "base64"

    def to_hex(string)
      string.unpack1("H*")
    end

    def from_hex(hex_string)
      [hex_string].pack("H*")
    end

    def to_base64(string)
      Base64.strict_encode64(string)
    end

    def from_base64(base64_string)
      Base64.strict_decode64(base64_string)
    end

    ## Converts a Stellar::PublicKey instance (or any typedef of it such as
    # Stellar::AccountID) to an address
    def pk_to_address(pk)
      Stellar::Util::StrKey.check_encode(:account_id, pk.ed25519!)
    end

    extend self
  end
end
