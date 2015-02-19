require "spec_helper"

RSpec.shared_examples "a keypair with both public and private keys" do
  it "can sign messages"

  it_behaves_like "a keypair with only a public key"
end

RSpec.shared_examples "a keypair with only a public key" do
  it "can verify messages"
end

describe Stellar::KeyPair do

  describe ".from_seed" do
    it "returns a keypair when provided a base58check encoded seed"
    it "raises an ArgumentError when the provided value is not base58 encoded"
    it "raises an ArgumentError when the provided value is not a :seed versioned base58 value"

    it_behaves_like "a keypair with both public and private keys"
  end

  describe ".from_raw_seed" do
    it "returns a keypair when the provided value is a 32-byte string"
    it "raises an ArgumentError when the provided is not 32-bytes"
    it "raises an ArgumentError when the provided value is a 32-character, but > 32-byte string (i.e. multi-byte characters)"

    it_behaves_like "a keypair with both public and private keys"
  end

  describe ".from_public_key" do
    it "returns a keypair object when the provided value is a 32-byte string"
    it "raises an ArgumentError when the provided is not 32-bytes"
    it "raises an ArgumentError when the provided value is a 32-character, but > 32-byte string (i.e. multi-byte characters)"

    it_behaves_like "a keypair with only a public key"
  end

  describe ".from_address" do
    it_behaves_like "a keypair with only a public key"
  end

  describe ".random" do
    subject{ Stellar::KeyPair.random }

    it "returns a new KeyPair every time" do
      other = Stellar::KeyPair.random
      expect(subject.raw_seed == other.raw_seed).to eq(false)
    end

    it_behaves_like "a keypair with both public and private keys"
  end

  describe "#public_key"
  describe "#raw_seed"
  describe "#address"
  describe "#seed"
  describe "#sign?"
  describe "#verify"
end
