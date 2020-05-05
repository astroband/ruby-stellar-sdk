module Stellar
  # Provides a container for well-known network passphrases, such as the main network and SDF test network
  module Networks

    PUBLIC  = "Public Global Stellar Network ; September 2015"
    TESTNET = "Test SDF Network ; September 2015"

  end

  # Configures the default stellar network passphrase for the current process.  Unless otherwise
  # specified in a method that needs the passphrase, this value will be used.
  #
  # NOTE:  This method is not thread-safe.  It's best to just call this at startup once and use the other
  #        methods of specifying a network if you need two threads in the same process to communicate with
  #        different networks
  #
  # @see Stellar.default_network
  # @see Stellar.on_network
  def self.default_network=(passphrase)
    @default_network = passphrase
  end

  # Returns the passphrase for the currently-configured network, as set by Stellar.default_network
  # or Stellar.on_network
  def self.current_network
    Thread.current["stellar_network_passphrase"] || 
    @default_network || 
    Stellar::Networks::TESTNET
  end

  # Returns the id for the currently configured network, suitable for use in generating
  # a signature base string or making the root account's keypair.
  def self.current_network_id
    Digest::SHA256.digest(self.current_network) 
  end

  # Executes the provided block in the context of the provided network.
  def self.on_network(passphrase, &block)
    old = Thread.current["stellar_network_passphrase"]
    Thread.current["stellar_network_passphrase"] = passphrase
    block.call
  ensure
    Thread.current["stellar_network_passphrase"] = old
  end
end
