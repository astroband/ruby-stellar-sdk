module Stellar
  module DSL
    module_function

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
      ClaimPredicate.compose(&block)
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

    # Converts subject to a Stellar::Account.
    #
    # @param [Asset, String, nil] subject
    # @return [Stellar::Account] instance of the Stellar::Asset
    # @raise [TypeError] if subject cannot be converted to Stellar::Asset
    def Account(subject = nil)
      case subject
      when Account
        subject
      when /^G[A-Z0-9]{55}$/, /^M[A-Z0-9]{68}$/
        Account.from_address(subject.to_str)
      when nil
        Account.random
      else
        Account.new(KeyPair(subject))
      end
    rescue
      raise TypeError, "Cannot convert #{subject.inspect} to Stellar::Account"
    end

    # Converts subject to a Stellar::Asset.
    #
    # @param subject [Stellar::Asset, Array, String, nil]
    # @return [Stellar::Asset] instance of the Stellar::Asset
    # @raise [TypeError] if subject cannot be converted to Stellar::Asset
    def Asset(subject = nil)
      case subject
      when Asset
        subject
      when Array
        raise TypeError, "Invalid asset type #{subject[0]}" unless [:native, :alphanum4, :alphanum12].include?(subject[0])
        Asset.send(*subject)
      when nil, /^(XLM[-:])?native$/
        Asset.native
      when /^([0-9A-Z]{1,4})[-:](G[A-Z0-9]{55})$/
        Asset.alphanum4($1, Account($2))
      when /^([0-9A-Z]{5,12})[-:](G[A-Z0-9]{55})$/
        Asset.alphanum12($1, Account($2))
      else
        raise TypeError, "Cannot convert #{subject.inspect} to Stellar::Asset"
      end
    end

    # Converts subject to a Stellar::KeyPair.
    #
    # @param subject [String, Stellar::Account, Stellar::PublicKey, Stellar::SignerKey, Stellar::Keypair] subject.
    # @return [Stellar::Keypair] Stellar::Keypair instance.
    # @raise [TypeError] if subject cannot be converted to Stellar::KeyPair
    def KeyPair(subject = nil)
      case subject
      when ->(subj) { subj.respond_to?(:to_keypair) }
        subject.to_keypair
      when PublicKey
        KeyPair.from_public_key(subject.value)
      when SignerKey
        KeyPair.from_raw_seed(subject.value)
      when /^G[A-Z0-9]{55}$/
        KeyPair.from_address(subject.to_str)
      when /^S[A-Z0-9]{55}$/
        KeyPair.from_seed(subject.to_str)
      when /^.{32}$/
        KeyPair.from_raw_seed(subject.to_str)
      when nil
        KeyPair.random
      else
        raise TypeError, "Cannot convert #{subject.inspect} to Stellar::KeyPair"
      end
    end

    # Provides conversion from different input types into the SignerKey to use in ManageData operation.
    #
    # @param input [String, Stellar::Account, Stellar::PublicKey, Stellar::SignerKey, Stellar::Keypair] subject.
    # @return [Stellar::SignerKey] Stellar::SignerKey instance.
    def SignerKey(input = nil)
      case input
      when Transaction
        SignerKey.pre_auth_tx(input.hash)
      when /^[0-9A-Za-z+\/=]{44}$/
        SignerKey.hash_x(Stellar::Convert.from_base64(input))
      when /^[0-9a-f]{64}$/
        SignerKey.hash_x(Stellar::Convert.from_hex(input))
      when /^.{32}$/
        SignerKey.hash_x(input)
      else
        SignerKey.ed25519(KeyPair(input))
      end
    end
  end

  include DSL
end
