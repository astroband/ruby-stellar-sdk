module Stellar
  #
  # Generic format conversion module
  #
  module Convert
    require 'base64'

    def to_hex(string)
      string.unpack("H*").first
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

    def base58
      Stellar::Util::Base58.stellar
    end

    def pk_to_address(pk)
      base58.check_encode(:account_id, pk)
    end

    extend self
  end
end
