require 'hyperclient'

module Stellar
  class Client
    include Contracts

    def self.default(options={})
      new options.merge({
        horizon:   "http://horizon.stellar.org"
      })
    end

    def self.default_testnet(options={})
      new options.merge({
        horizon:   "http://horizon-stg.stellar.org",
        friendbot: "http://api-stg.stellar.org",
      })
    end

    def self.localhost(options={})
      new options.merge({
        horizon: "http://127.0.0.1:3000", #TODO: figure out a real port
      })
    end

    attr_reader :horizon

    Contract ({horizon: String}) => Any
    def initialize(options)
      @options = options
      @horizon = Hyperclient.new(options[:horizon])
    end

    def friendbot(account)
      raise NotImplementedError
    end

    # Contract Stellar::Account => Stellar::AccountInfo
    Contract Stellar::Account => Any
    def account_info(account)
      address  = account.address
      @horizon.accounts(address:address)
    end

    Contract ({
      from:     Stellar::Account, 
      to:       Stellar::Account, 
      amount:   Stellar::Amount
    }) => Any
    def send_payment(options={})
      from     = options[:from]
      sequence = options[:sequence] || account_info(from).sequence

      payment = Stellar::Transaction.payment({
        account:     from.keypair,
        destination: options[:to].keypair,
        sequence:    sequence,
        amount:      options[:amount].to_payment,
      })

      envelope_hex = payment.to_envelope(from.keypair).to_xdr(:hex)

      @horizon.transactions._post(tx: envelope_hex)
    end

    private
    # Contract HashOf[Symbol,Any] => Stellar::Horizon::Response
    # def horizon_request(options={})
    #   load_horizon_root

    #   response = @horizon.request(options)

    #   if response.
    # end

    def friendbot_request
      
    end

    def load_horizon_root
      return if defined? @horizon_root

      # TODO: load uri templates from api root
    end
  end
end