module Stellar
  TransactionEnvelope.class_eval do

    # 
    # Checks to ensure that every signature for the envelope is
    # a valid signature of one of the provided `key_pairs`
    # 
    # NOTE: this does not do any authorization checks, which requires access to
    # the current ledger state.
    # 
    # @param *key_pairs [Array<Stellar::KeyPair>] The key pairs to check the envelopes signatures against
    # 
    # @return [Boolean] true if all signatures are from the provided key_pairs and validly sign the tx's hash
    def signed_correctly?(*key_pairs)
      hash = tx.hash
      return false if signatures.empty?
      
      signatures.all?{|sig| key_pairs.any?{|kp| kp.verify(sig, hash)}}
    end
  end
end