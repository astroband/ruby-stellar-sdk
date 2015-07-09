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
      let(:seed){ "allmylifemyhearthasbeensearching" }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context "provided value is not base58 encoded as a seed" do
      let(:raw_seed){ "allmylifemyhearthasbeensearching" }
      let(:seed){ Stellar::Util::Base58.stellar.check_encode(:account_id, raw_seed) }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end
  end

  describe ".from_raw_seed" do
    subject{ Stellar::KeyPair.from_raw_seed(raw_seed) }

    context "when the provided value is a 32-byte string" do
      let(:raw_seed){ "allmylifemyhearthasbeensearching" }
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

  describe ".from_address" do
    subject{ Stellar::KeyPair.from_address(address) }

    context "when provided a base58check encoded account_id" do
      let(:address){ "gsYRSEQhTffqA9opPepAENCr2WG6z5iBHHubxxbRzWaHf8FBWcu" }
      it { should be_a(Stellar::KeyPair) }
    end

    context "provided value is not base58 encoded" do
      let(:address){ "some address" }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context "provided value is not base58 encoded as an account_id" do
      let(:public_key){ "\xFF" * 32 }
      let(:address){ Stellar::Util::Base58.stellar.check_encode(:seed, public_key) }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

  end

  describe ".random" do
    subject{ Stellar::KeyPair.random }

    it "returns a new KeyPair every time" do
      other = Stellar::KeyPair.random
      expect(subject.raw_seed == other.raw_seed).to eq(false)
    end
  end

  describe "#raw_public_key" do
    let(:key_pair){ Stellar::KeyPair.random }
    subject{ key_pair.raw_public_key }

    it { should be_a(String) }
    it { should have_length(32) }
  end

  describe "#public_key" do
    let(:key_pair){ Stellar::KeyPair.random }
    subject{ key_pair.public_key }

    it { should be_a(Stellar::PublicKey) }
  end

  describe "#account_id" do
    let(:key_pair){ Stellar::KeyPair.random }
    subject{ key_pair.account_id }

    it { should be_a(Stellar::AccountID) }

    it "contains the public key" do
        expect(subject.ed25519!).to eql(key_pair.raw_public_key)
    end
  end

  describe "#raw_seed" do
    let(:key_pair){ Stellar::KeyPair.random }
    subject{ key_pair.raw_seed }

    it { should be_a(String) }
    it { should have_length(32) }
  end

  describe "#signature_hint" do
    let(:key_pair){ Stellar::KeyPair.random }
    subject{ key_pair.signature_hint }

    it { should be_a(String) }
    it { should have_length(4) }

    it "is the last 4 bytes of the encoded account_id" do
      expected = key_pair.account_id.to_xdr[-4..-1]
      expect(subject).to eql(expected)
    end
  end

  describe "#address" do
    let(:key_pair){ Stellar::KeyPair.random }
    subject{ key_pair.address }
    it{ should be_base58_check(:account_id)}
  end

  describe "#seed" do
    let(:key_pair){ Stellar::KeyPair.random }
    subject{ key_pair.seed }
    it{ should be_base58_check(:seed)}
  end

  describe "#sign" do
    let(:message) { "hello" }
    subject{ key_pair.sign(message) }

    context "when the key_pair has no private key" do
      let(:key_pair){ Stellar::KeyPair.from_public_key("\x00" * 32)}

      it{ expect{ subject }.to raise_error("no private key") }
    end

    context "when the key_pair has both public/private keys" do
      let(:key_pair){ Stellar::KeyPair.from_raw_seed("\x00" * 32)}

      it { should have_length(64) }

      it "should be a ed25519 signature" do
        verification = key_pair.rbnacl_verify_key.verify(subject, message)
        expect(verification).to be_truthy
      end

      context "when the message is nil" do
        let(:message){ nil }
        it { expect{subject}.to raise_error(TypeError) }
      end
    end
  end

  describe "#verify" do
    let(:key_pair)  { Stellar::KeyPair.random }
    let(:message)   { "hello" }
    subject         { key_pair.verify(signature, message) }

    context "when the signature is correct" do
      let(:signature) { key_pair.sign(message) }
      it{ should be_truthy }
    end

    context "when the signature is incorrect" do
      let(:signature) { key_pair.sign("some other message") }
      it{ should be_falsey }
    end

    context "when the signature is invalid" do
      let(:signature) { "food" }
      it{ should be_falsey }
    end

    context "when the signature is from a different key" do
      let(:signature) { Stellar::KeyPair.random.sign(message) }
      it{ should be_falsey }
    end

  end

  describe "#sign?" do
    subject{ key_pair.sign? }

    context "when the key_pair has no private key" do
      let(:key_pair){ Stellar::KeyPair.from_public_key("\x00" * 32)}
      it{ should eq(false) }
    end

    context "when the key_pair has both public/private keys" do
      let(:key_pair){ Stellar::KeyPair.from_raw_seed("\x00" * 32)}
      it{ should eq(true) }
    end
  end
end
