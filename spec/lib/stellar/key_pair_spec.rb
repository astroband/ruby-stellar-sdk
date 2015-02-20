# encoding: utf-8
require "spec_helper"

describe Stellar::KeyPair do

  describe ".from_seed" do
    subject{ Stellar::KeyPair.from_seed(seed) }

    context "when provided a base58check encoded seed" do
      let(:seed){ "s9aaUNPaT9t1x7vCeDzQYvLZDm5XxSUKkwnqQowV6D3kMr678uZ" }
      it { should be_a(Stellar::KeyPair) }
    end

    context "provided value is not base58 encoded" do
      let(:seed){ "masterpassphrasemasterpassphrase" }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context "provided value is not base58 encoded" do
      let(:raw_seed){ "masterpassphrasemasterpassphrase" }
      let(:seed){ Stellar::Util::Base58.stellar.check_encode(:account_id, raw_seed) }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end
  end

  describe ".from_raw_seed" do
    subject{ Stellar::KeyPair.from_raw_seed(raw_seed) }
    
    context "when the provided value is a 32-byte string" do
      let(:raw_seed){ "masterpassphrasemasterpassphrase" }
      it { should be_a(Stellar::KeyPair) }
    end

    context "when the provided value is < 32-byte string" do
      let(:raw_seed){ "\xFF" * 31 }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context "when the provided value is > 32-byte string" do
      let(:raw_seed){ "\xFF" * 33 }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context "when the provided value is a 32 character, but > 32 byte string (i.e. multi-byte characters)" do
      let(:raw_seed){ "ü" + ("\x00" * 31) }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end
  end

  describe ".from_public_key" do
    subject{ Stellar::KeyPair.from_public_key(key) }

    context "when the provided value is a 32-byte string" do
      let(:key){ "\xFF" * 32 }
      it { should be_a(Stellar::KeyPair) }
    end

    context "when the provided value is < 32-byte string" do
      let(:key){ "\xFF" * 31 }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context "when the provided value is > 32-byte string" do
      let(:key){ "\xFF" * 33 }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context "when the provided value is a 32 character, but > 32 byte string (i.e. multi-byte characters)" do
      let(:key){ "ü" + ("\x00" * 31) }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end
  end

  describe ".from_address"

  describe ".random" do
    subject{ Stellar::KeyPair.random }

    it "returns a new KeyPair every time" do
      other = Stellar::KeyPair.random
      expect(subject.raw_seed == other.raw_seed).to eq(false)
    end
  end

  describe "#public_key"
  describe "#raw_seed"
  describe "#address"
  describe "#seed"
  describe "#sign?"
  describe "#verify"
end
