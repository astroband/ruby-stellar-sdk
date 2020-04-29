# frozen_string_literal: true

require 'toml-rb'
require 'uri'
require 'faraday'
require 'json'

module Stellar
  class Account
    include Contracts

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
      _, domain = federated_name.split('*')
      raise InvalidFederationAddress if domain.nil?

      domain_req = Faraday.new("https://#{domain}/.well-known/stellar.toml").get

      raise InvalidStellarDomain, 'Domain does not contain stellar.toml file' unless domain_req.status == 200

      fed_server_url = TomlRB.parse(domain_req.body)['FEDERATION_SERVER']
      raise InvalidStellarTOML, 'Invalid Stellar TOML file' if fed_server_url.nil?

      unless fed_server_url =~ URI::DEFAULT_PARSER.make_regexp
        raise InvalidFederationURL, 'Invalid Federation Server URL'
      end

      lookup_req = Faraday.new(fed_server_url).get do |req|
        req.params[:q] = federated_name
        req.params[:type] = 'name'
      end

      raise AccountNotFound, 'Account not found' unless lookup_req.status == 200

      JSON.parse(lookup_req.body)['account_id']
    end

    def self.master
      keypair = Stellar::KeyPair.from_raw_seed('allmylifemyhearthasbeensearching')
      new(keypair)
    end

    attr_reader :keypair

    Contract Stellar::KeyPair => Any
    def initialize(keypair)
      @keypair = keypair
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
