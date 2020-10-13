require "toml-rb"
require "uri"
require "faraday"
require "json"

module Stellar
  class Account
    delegate :address, to: :keypair

    def self.random
      keypair = Stellar::KeyPair.random
      new(keypair)
    end

    def self.from_seed(seed)
      keypair = Stellar::KeyPair.from_seed(seed)
      new(keypair)
    end

    def self.from_address(address)
      keypair = Stellar::KeyPair.from_address(address)
      new(keypair)
    end

    def self.lookup(federated_name)
      _, domain = federated_name.split("*")
      if domain.nil?
        raise InvalidFederationAddress.new
      end

      domain_req = Faraday.new("https://#{domain}/.well-known/stellar.toml").get

      unless domain_req.status == 200
        raise InvalidStellarDomain.new("Domain does not contain stellar.toml file")
      end

      fed_server_url = TomlRB.parse(domain_req.body)["FEDERATION_SERVER"]
      if fed_server_url.nil?
        raise InvalidStellarTOML.new("Invalid Stellar TOML file")
      end

      unless fed_server_url&.match?(URI::DEFAULT_PARSER.make_regexp)
        raise InvalidFederationURL.new("Invalid Federation Server URL")
      end

      lookup_req = Faraday.new(fed_server_url).get { |req|
        req.params[:q] = federated_name
        req.params[:type] = "name"
      }

      unless lookup_req.status == 200
        raise AccountNotFound.new("Account not found")
      end

      JSON.parse(lookup_req.body)["account_id"]
    end

    def self.master
      keypair = Stellar::KeyPair.from_raw_seed("allmylifemyhearthasbeensearching")
      new(keypair)
    end

    attr_reader :keypair

    # @param [Stellar::KeyPair] keypair
    def initialize(keypair)
      @keypair = keypair
    end

    def to_keypair
      keypair
    end
  end

  class AccountNotFound < StandardError
  end

  class InvalidStellarTOML < StandardError
  end

  class InvalidFederationAddress < StandardError
  end

  class InvalidStellarDomain < StandardError
  end

  class InvalidFederationURL < StandardError
  end
end
