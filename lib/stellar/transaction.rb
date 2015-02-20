module Stellar
  Transaction.class_eval do

    def self.payment(attributes={})
      account     = attributes[:account]
      destination = attributes[:destination]
      sequence    = attributes[:sequence]
      amount      = attributes[:amount]

      raise ArgumentError unless account.is_a?(KeyPair) && account.sign?
      raise ArgumentError unless destination.is_a?(KeyPair)

      new.tap do |result|
        result.seq_num = sequence
        result.account = account.public_key
        result.apply_defaults

        payment = PaymentTx.send(*amount)
        payment.destination = destination.public_key
        payment.apply_defaults

        result.body = payment.to_tx_body

      end
    end

    def sign(key_pair)
      key_pair.sign(hash)
    end

    def hash
      Digest::SHA256.digest(to_xdr)
    end

    def to_envelope(*key_pairs)
      signatures = key_pairs.map(&method(:sign))
      
      TransactionEnvelope.new({
        :signatures => signatures,
        :tx => self
      })
    end

    def apply_defaults
      self.max_fee    ||= 10
      self.min_ledger ||= 0

      # NOTE: the effective limit of max_ledger is (2^63 - 1), since while
      # the XDR for is an unsigned 64-bit integer, the sql systems that store
      # the transaction data do not support unsigned 64-bit integers. 
      self.max_ledger ||= 2**63 - 1
    end
  end
end