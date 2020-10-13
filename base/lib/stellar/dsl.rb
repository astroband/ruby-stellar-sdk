module Stellar
  module DSL
    # Constructs a new ClaimPredicate using DSL
    #
    # @example fulfilled during [T+5min, T+60min] period, where T refers to claimable balance entry creation time
    #   Stellar::ClaimPredicate { before_relative_time(1.hour) & ~before_relative_time(5.minutes) }
    #
    # @example not fulfilled starting from today midnight until tomorrow midnight,
    #   Stellar::ClaimPredicate { before_absolute_time(Date.today.end_of_day) | ~before_absolute_time(Date.tomorrow.end_of_day) }
    #
    # @example always fulfilled
    #   Stellar::ClaimPredicate { }
    def ClaimPredicate(&block)
      return ClaimPredicate.unconditional unless block
      ClaimPredicate.construct(&block)
    end

    def Claimant(destination, &block)
      Claimant.new(
        ClaimantType.claimant_type_v0,
        Claimant::V0.new(
          destination: KeyPair(destination).account_id,
          predicate: ClaimPredicate(&block)
        )
      )
    end

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
