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

  describe ".lookup" do
    it "should peforms federation lookup", vcr: {record: :once, match_requests_on: [:method]} do
      account_id = described_class.lookup("john@email.com*stellarfed.org")
      expect(account_id).to eq "GDSRO6H2YM6MC6ZO7KORPJXSTUMBMT3E7MZ66CFVNMUAULFG6G2OP32I"
    end

    it "should handle 404 request when performing federation lookup", vcr: {record: :once, match_requests_on: [:method]} do
      expect { described_class.lookup("jane@email.com*stellarfed.org") }.to raise_error(Stellar::AccountNotFound)
    end

    it "should handle domains that are not federation servers", vcr: {record: :once, match_requests_on: [:method]} do
      expect { described_class.lookup("john*stellar.org") }.to raise_error(Stellar::InvalidStellarDomain)
    end
  end

  describe "#keypair" do
    it "generates a Stellar account with a random keypair" do
      account = described_class.random
      expect(account.keypair).to be_a Stellar::KeyPair
    end
  end
end
