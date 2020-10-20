module Stellar
  # Provides a container for well-known network passphrases, such as the main network and SDF test network
  module Networks
    PUBLIC = "Public Global Stellar Network ; September 2015"
    TESTNET = "Test SDF Network ; September 2015"
  end

  # Configures the default stellar network passphrase for the current process.  Unless otherwise
  # specified in a method that needs the passphrase, this value will be used.
  #
  # NOTE:  This method is not thread-safe.  It's best to just call this at startup once and use the other
  #        methods of specifying a network if you need two threads in the same process to communicate with
  #        different networks
  #
  # @see Stellar.on_network
  mattr_accessor :default_network, default: Networks::TESTNET

  # Stellar network passphrase selected for current thread
  #
  # @see Stellar.current_network
  # @see Stellar.on_network
  thread_mattr_accessor :network

  # Returns the passphrase for the network currently active per-thread with a fallback to `Stellar.default_network`
  def self.current_network
    network.presence || default_network
  end

  # Returns the id for the currently configured network, suitable for use in generating
  # a signature base string or making the root account's keypair.
  def self.current_network_id
    Digest::SHA256.digest(current_network)
  end

  # Executes the provided block in the context of the provided network.
  def self.on_network(passphrase, &block)
    old = network
    self.network = passphrase
    block.call
  ensure
    self.network = old
  end
end
