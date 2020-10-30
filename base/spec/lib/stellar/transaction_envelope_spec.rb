RSpec.describe Stellar::TransactionEnvelope do
  let(:sender) { Stellar::KeyPair.random }
  let(:receiver) { Stellar::KeyPair.random }
  let(:transaction) do
    Stellar::TransactionBuilder.new(
      source_account: sender, sequence_number: 1
    ).add_operation(
      Stellar::Operation.payment(
        destination: receiver, amount: [:native, 20000000]
      )
    ).set_timeout(0).build
  end

  let(:envelope) { transaction.to_envelope(*signers) }

  describe "#signed_correctly?" do
    subject { envelope.signed_correctly?(*verifiers) }

    context "when unsigned" do
      let(:signers) { [] }
      let(:verifiers) { [sender] }

      it { is_expected.to be_falsey }
    end

    context "when signed by a single account" do
      let(:signers) { [sender] }
      let(:verifiers) { signers }

      context "and signed correctly" do
        it { is_expected.to be_truthy }
      end

      context "and the signature is corrupted" do
        before(:each) { envelope.signatures.first.signature = "\xFF" * 32 }
        it { is_expected.to be_falsey }
      end

      context "and the signature is from a different message" do
        before(:each) { envelope.signatures = [sender.sign_decorated("hello")] }
        it { is_expected.to be_falsey }
      end

      context "and the key for the signing account is not provided" do
        let(:verifiers) { [] }
        it { is_expected.to be_falsey }
      end

      context "and the key for the signing account is wrong" do
        let(:verifiers) { [receiver] }
        it { is_expected.to be_falsey }
      end
    end

    context "when signed by a multiple accounts" do
      let(:alternate_signer) { Stellar::KeyPair.random }
      let(:signers) { [sender, alternate_signer] }
      let(:verifiers) { signers }

      context "and all public keys are provided" do
        it { is_expected.to be_truthy }
      end

      context "and all public keys are provided, with additional unused keys provided" do
        let(:verifiers) { signers + [Stellar::KeyPair.random] }
        it { is_expected.to be_truthy }
      end

      context "and not all public keys for the signers are provided" do
        let(:verifiers) { [alternate_signer] }
        it { is_expected.to be_falsey }
      end

      context "and one of the signatures is corrupted" do
        before(:each) { envelope.signatures.last.signature = "\xFF" * 32 }
        it { is_expected.to be_falsey }
      end

      context "and the signature is from a different message" do
        before(:each) { envelope.signatures = signers.map { |s| s.sign_decorated("hello") } }
        it { is_expected.to be_falsey }
      end
    end
  end

  describe "#hash" do
    let(:signers) { [sender] }
    subject { envelope.hash }
    it { is_expected.to eq(Digest::SHA256.digest(envelope.tx.signature_base)) }
  end
end
