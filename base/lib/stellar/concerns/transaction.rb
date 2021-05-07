module Stellar::Concerns
  module Transaction
    # Returns the string of bytes that, when hashed, provide the value which
    # should be signed to create a valid stellar transaction signature
    def signature_base
      signature_base_prefix + to_xdr
    end

    def sign(key_pair)
      key_pair.sign(hash)
    end

    def sign_decorated(key_pair)
      key_pair.sign_decorated(hash)
    end

    def hash
      Digest::SHA256.digest(signature_base)
    end

    def merge(other)
      cloned = from_xdr(to_xdr)
      cloned.operations += other.to_operations
      cloned
    end

    #
    # Extracts the operations from this single transaction,
    # setting the source account on the extracted operations.
    #
    # Useful for merging transactions.
    #
    # @return [Array<Operation>] the operations
    def to_operations
      codec = XDR::VarArray[Stellar::Operation]
      ops = respond_to?(:operations) ? operations : inner_tx.value.tx.operations
      cloned = codec.from_xdr(codec.to_xdr(ops))
      cloned.each do |op|
        op.source_account ||= source_account
      end
    end

    def apply_defaults
      self.operations ||= []
      self.fee ||= 100
      self.memo ||= Stellar::Memo.new(:memo_none)
      self.ext ||= Stellar::Transaction::Ext.new 0
    end
  end
end
