module Stellar
  module DSL
    def Asset(subject = nil)
      case subject
      when Asset
        subject
      when nil, /^(XLM-)?native$/
        Asset.native
      when /^([0-9A-Z]{1,4})-(G[A-Z0-9]{55})$/
        Asset.alphanum4($1, KeyPair($2))
      when /^([0-9A-Z]{5,12})-(G[A-Z0-9]{55})$/
        Asset.alphanum12($1, KeyPair($2))
      else
        raise TypeError, "Cannot convert #{subject.inspect} to Stellar::Asset"
      end
    end

    # Generates Stellar::Keypair from subject, use Stellar::Client.to_keypair as shortcut.
    # @param subject [String|Stellar::Account|Stellar::PublicKey|Stellar::SignerKey|Stellar::Keypair] subject.
    # @return [Stellar::Keypair] Stellar::Keypair instance.
    def KeyPair(subject = nil)
      case subject
      when ->(subj) { subj.respond_to?(:to_keypair) }
        subject.to_keypair
      when /G[A-Z0-9]{55}/
        KeyPair.from_address(subject)
      when /S[A-Z0-9]{55}/
        KeyPair.from_seed(subject)
      when PublicKey
        KeyPair.from_public_key(subject.value)
      when SignerKey
        KeyPair.from_raw_seed(subject.value)
      when nil
        KeyPair.random
      else
        raise TypeError, "Cannot convert #{subject.inspect} to Stellar::KeyPair"
      end
    end
  end

  extend DSL
end
