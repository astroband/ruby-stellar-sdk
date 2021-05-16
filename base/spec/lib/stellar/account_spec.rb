RSpec.describe Stellar::Account do
  describe ".random" do
    it "generates a Stellar account with a random keypair" do
      account = described_class.random
      expect(account.address).to match account.keypair.address
    end
  end

  describe ".from_seed" do
    let(:random_account) { described_class.random }
    subject(:account) do
      described_class.from_seed(random_account.keypair.seed)
    end

    it "generates an account from a seed" do
      expect(account.keypair.seed).to eq random_account.keypair.seed
    end
  end

  describe ".from_address" do
    let(:random_account) { described_class.random }
    subject(:account) do
      described_class.from_address(random_account.address)
    end

    it "generates an account from an address" do
      expect(account.address).to eq random_account.address
    end
  end

  describe "#keypair" do
    it "generates a Stellar account with a random keypair" do
      account = described_class.random
      expect(account.keypair).to be_a Stellar::KeyPair
    end
  end
end
