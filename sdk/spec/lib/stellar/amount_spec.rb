require "spec_helper"

module Stellar
  RSpec.describe Amount do
    describe "#to_payment" do
      context "when asset is the native type" do
        it "returns an array of values" do
          amount = described_class.new(100)
          payment = amount.to_payment
          expect(payment[0]).to eq :native
          expect(payment[1]).to eq 100
        end
      end

      context "when asset is alphanum4" do
        let(:issuer_account) { Stellar::Account.random }

        it "returns an array of values" do
          asset = Stellar::Asset.alphanum4("BTC", issuer_account.keypair)
          amount = described_class.new(100, asset)

          payment = amount.to_payment
          expect(payment[0]).to eq :alphanum4
          expect(payment[1]).to include "BTC"
          expect(payment[2].public_key.value)
            .to eq issuer_account.keypair.public_key.value
          expect(payment[3]).to eq 100
        end
      end

      context "when asset is alphanum12" do
        let(:issuer_account) { Stellar::Account.random }

        it "returns an array of values" do
          asset = Stellar::Asset.alphanum12("LONGNAME", issuer_account.keypair)
          amount = described_class.new(100, asset)

          payment = amount.to_payment
          expect(payment[0]).to eq :alphanum12
          expect(payment[1]).to include "LONGNAME"
          expect(payment[2].public_key.value)
            .to eq issuer_account.keypair.public_key.value
          expect(payment[3]).to eq 100
        end
      end
    end

    describe "#inspect" do
      context "when asset is not explicitly supplied" do
        it "uses the native asset type" do
          amount = described_class.new(200)
          expect(amount.inspect).to eq "#<Stellar::Amount native(200)>"
        end
      end

      context "when asset is supplied" do
        let(:issuer_account) { Stellar::Account.random }

        it "uses the supplied asset type" do
          asset = Stellar::Asset.alphanum4("BTC", issuer_account.keypair)
          amount = described_class.new(1_000000, asset)
          expect(amount.inspect).to eq "#<Stellar::Amount #{asset}(1000000)>"
        end
      end
    end
  end
end
