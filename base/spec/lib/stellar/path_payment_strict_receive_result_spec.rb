RSpec.describe Stellar::PathPaymentStrictReceiveResult, "#send_amount" do
  context "when the result is not successful" do
    subject { Stellar::PathPaymentStrictReceiveResult.new(:path_payment_strict_receive_malformed) }

    it "raises an exception if the result is not successful" do
      expect { subject.send_amount }.to raise_error(XDR::ArmNotSetError)
    end
  end

  context "when the result has no claimed offers" do
    let(:simple_success) { Stellar::SimplePaymentResult.new(amount: 100) }
    let(:path_success) { Stellar::PathPaymentStrictReceiveResult::Success.new(last: simple_success) }

    subject { Stellar::PathPaymentStrictReceiveResult.new(:path_payment_strict_receive_success, path_success) }

    it "returns the amount from the 'last' component" do
      expect(subject.send_amount).to eql(100)
    end
  end

  context "with simple 1-hop result" do
    let(:simple_success) { Stellar::SimplePaymentResult.new(amount: 100) }
    let(:offers) do
      [Stellar::ClaimOfferAtom.new(asset_bought: Stellar::Asset.native, amount_bought: 200)]
    end

    let(:path_success) do
      Stellar::PathPaymentStrictReceiveResult::Success.new({
        offers: offers,
        last: simple_success
      })
    end

    subject { Stellar::PathPaymentStrictReceiveResult.new(:path_payment_strict_receive_success, path_success) }

    it "returns the amount from the ClaimOfferAtom" do
      expect(subject.send_amount).to eql(200)
    end
  end

  context "with 1-hop result that claimed multiple offers" do
    let(:simple_success) { Stellar::SimplePaymentResult.new(amount: 100) }
    let(:offers) do
      [
        Stellar::ClaimOfferAtom.new(asset_bought: Stellar::Asset.native, amount_bought: 200),
        Stellar::ClaimOfferAtom.new(asset_bought: Stellar::Asset.native, amount_bought: 200)
      ]
    end

    let(:path_success) do
      Stellar::PathPaymentStrictReceiveResult::Success.new({
        offers: offers,
        last: simple_success
      })
    end

    subject { Stellar::PathPaymentStrictReceiveResult.new(:path_payment_strict_receive_success, path_success) }

    it "returns the summed amount from the ClaimOfferAtoms" do
      expect(subject.send_amount).to eql(400)
    end
  end

  context "with multi-hop result that claimed multiple offers" do
    let(:simple_success) { Stellar::SimplePaymentResult.new(amount: 100) }
    let(:otherAsset) { Stellar::Asset.alphanum4("USD", Stellar::KeyPair.random) }
    let(:offers) do
      [
        Stellar::ClaimOfferAtom.new(asset_bought: Stellar::Asset.native, amount_bought: 200),
        Stellar::ClaimOfferAtom.new(asset_bought: Stellar::Asset.native, amount_bought: 200),
        Stellar::ClaimOfferAtom.new(asset_bought: otherAsset, amount_bought: 200)
      ]
    end

    let(:path_success) do
      Stellar::PathPaymentStrictReceiveResult::Success.new({
        offers: offers,
        last: simple_success
      })
    end

    subject { Stellar::PathPaymentStrictReceiveResult.new(:path_payment_strict_receive_success, path_success) }

    it "returns the summed amount from the ClaimOfferAtoms" do
      expect(subject.send_amount).to eql(400)
    end
  end
end
