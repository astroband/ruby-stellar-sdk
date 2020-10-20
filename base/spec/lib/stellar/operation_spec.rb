RSpec.describe Stellar::Operation, ".payment" do
  it "correctly translates the provided amount to the native representation" do
    op = Stellar::Operation.payment(destination: Stellar::KeyPair.random, amount: [:native, 20])
    expect(op.body.value.amount).to eql(20_0000000)
    op = Stellar::Operation.payment(destination: Stellar::KeyPair.random, amount: [:native, "20"])
    expect(op.body.value.amount).to eql(20_0000000)
  end
end

RSpec.describe "path payment operations" do
  let(:destination) { Stellar::KeyPair.random }
  let(:send_asset_issuer) { Stellar::KeyPair.master }
  let(:send_asset) { Stellar::Asset.alphanum4("USD", send_asset_issuer) }
  let(:dest_asset_issuer) { Stellar::KeyPair.master }
  let(:dest_asset) { Stellar::Asset.alphanum4("EUR", dest_asset_issuer) }
  let(:amount) { [Stellar::Asset.alphanum4(dest_asset.code, dest_asset_issuer), 9.2] }
  let(:with) { [Stellar::Asset.alphanum4(send_asset.code, send_asset_issuer), 10] }

  describe Stellar::Operation, ".path_payment" do
    # test both forms of arrays
    let(:amount) { [Stellar::Asset.alphanum4("USD", Stellar::KeyPair.master), 10] }
    let(:with) { [:alphanum4, "EUR", Stellar::KeyPair.master, 9.2] }

    context "with non-multiplexed destination" do
      let(:destination) { Stellar::KeyPair.random }

      it "works" do
        op = Stellar::Operation.path_payment(
          destination: destination,
          amount: amount,
          with: with
        )

        expect(op.body.arm).to eql(:path_payment_strict_receive_op)
        expect { op.to_xdr }.not_to raise_error
      end
    end
  end

  describe Stellar::Operation, ".path_payment_strict_receive" do
    it "works" do
      op = Stellar::Operation.path_payment_strict_receive(
        destination: destination,
        amount: amount,
        with: with
      )

      expect(op.body.arm).to eql(:path_payment_strict_receive_op)
      expect(op.body.value.destination).to eql(destination.muxed_account)
      expect(op.body.value.send_asset).to eql(send_asset)
      expect(op.body.value.dest_asset).to eql(dest_asset)
      expect(op.body.value.send_max).to eq(100000000)
      expect(op.body.value.dest_amount).to eq(92000000)
      expect { op.to_xdr }.not_to raise_error
    end
  end

  describe Stellar::Operation, ".path_payment_strict_send" do
    it "works" do
      op = Stellar::Operation.path_payment_strict_send(
        destination: destination,
        amount: amount,
        with: with
      )

      expect(op.body.arm).to eql(:path_payment_strict_send_op)
      expect(op.body.value.destination).to eql(destination.muxed_account)
      expect(op.body.value.send_asset).to eql(send_asset)
      expect(op.body.value.dest_asset).to eql(dest_asset)
      expect(op.body.value.send_amount).to eq(100000000)
      expect(op.body.value.dest_min).to eq(92000000)
      expect { op.to_xdr }.not_to raise_error
    end
  end
end

RSpec.describe Stellar::Operation, ".manage_data" do
  it "works" do
    op = Stellar::Operation.manage_data(name: "my name", value: "hello")
    expect(op.body.manage_data_op!.data_name).to eql("my name")
    expect(op.body.manage_data_op!.data_value).to eql("hello")
    expect { op.to_xdr }.to_not raise_error

    op = Stellar::Operation.manage_data(name: "my name")
    expect(op.body.manage_data_op!.data_name).to eql("my name")
    expect(op.body.manage_data_op!.data_value).to be_nil
    expect { op.to_xdr }.to_not raise_error
  end
end

RSpec.describe Stellar::Operation, ".change_trust" do
  let(:issuer) { Stellar::KeyPair.from_address("GDGU5OAPHNPU5UCLE5RDJHG7PXZFQYWKCFOEXSXNMR6KRQRI5T6XXCD7") }
  let(:asset) { Stellar::Asset.alphanum4("USD", issuer) }

  it "creates a ChangeTrustOp" do
    op = Stellar::Operation.change_trust(line: Stellar::Asset.alphanum4("USD", issuer))
    expect(op.body.value).to be_an_instance_of(Stellar::ChangeTrustOp)
    expect(op.body.value.line).to eq(Stellar::Asset.alphanum4("USD", issuer))
    expect(op.body.value.limit).to eq(9223372036854775807)
  end

  it "creates a ChangeTrustOp with an asset" do
    asset = Stellar::Asset.alphanum4("USD", issuer)
    op = Stellar::Operation.change_trust(line: asset, limit: 1234.75)
    expect(op.body.value).to be_an_instance_of(Stellar::ChangeTrustOp)
    expect(op.body.value.line).to eq(Stellar::Asset.alphanum4("USD", issuer))
    expect(op.body.value.limit).to eq(12347500000)
  end

  it "only allow sound `line` arguments" do
    expect {
      Stellar::Operation.change_trust(line: [:harmful_call, "USD", issuer])
    }.to raise_error(ArgumentError, "must be one of #{Stellar::Asset::TYPES}")
  end

  it "creates a ChangeTrustOp with limit" do
    op = Stellar::Operation.change_trust(line: Stellar::Asset.alphanum4("USD", issuer), limit: 1234.75)
    expect(op.body.value).to be_an_instance_of(Stellar::ChangeTrustOp)
    expect(op.body.value.line).to eq(Stellar::Asset.alphanum4("USD", issuer))
    expect(op.body.value.limit).to eq(12347500000)
  end

  it "throws ArgumentError for incorrect limit argument" do
    expect {
      Stellar::Operation.change_trust(line: Stellar::Asset.alphanum4("USD", issuer), limit: true)
    }.to raise_error(ArgumentError)
  end
end

RSpec.describe Stellar::Operation, ".allow_trust" do
  let(:issuer) { Stellar::KeyPair.from_address("GDGU5OAPHNPU5UCLE5RDJHG7PXZFQYWKCFOEXSXNMR6KRQRI5T6XXCD7") }
  let(:trustor) { Stellar::KeyPair.random }
  let(:asset) { Stellar::Asset.alphanum4("USD", issuer) }
  let(:authorize) { :full }
  subject { Stellar::Operation.allow_trust(trustor: trustor, authorize: authorize, asset: asset) }

  it "produces valid Stellar::AllowTrustOp body" do
    expect { subject.to_xdr }.not_to raise_error
  end

  describe "'authorize' parameter options" do
    {
      1 => [true, :full],
      0 => [false, :none],
      2 => [:maintain_liabilities]
    }.each do |output, inputs|
      inputs.each do |input|
        context "when 'authorize' parameter is #{input}" do
          let(:authorize) { input }

          it "sets authorize to #{output}" do
            expect(subject.body.value.authorize).to eq(output)
          end
        end
      end
    end

    context "when 'authorize' is invalid" do
      let(:authorize) { Stellar::TrustLineFlags.authorized_to_maintain_liabilities_flag.value + 1 }

      it "raises an error" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end
end

RSpec.shared_examples "XDR serializable" do
  it "roundtrips" do
    base64 = subject.to_xdr(:base64)
    expect(described_class.from_xdr(base64, :base64)).to eq(subject)
  end
end

RSpec.describe Stellar::Operation do
  let(:sponsor) { Stellar.KeyPair("GCLR75LIUXITGNHSKF7WAEJEWZTIVACKHFMYZTQCP4SKW5MCFXMZODWM") }
  let(:account) { Stellar.KeyPair("GDQLZTJBZT2KSDYWTS6TGCVSPNG6XXOLBMG3SXVFENASZTPKN4UPNAYV") }
  let(:attrs) { {source_account: sponsor} }

  describe ".begin_sponsoring_future_reserves" do
    before { attrs.merge!(sponsored: account) }
    subject(:operation) { described_class.begin_sponsoring_future_reserves(**attrs) }

    it_behaves_like "XDR serializable"
    its("source_account") { is_expected.to eq(sponsor.muxed_account) }
    its("body.switch.name") { is_expected.to eq("begin_sponsoring_future_reserves") }
    its("body.value") { is_expected.to be_a(Stellar::BeginSponsoringFutureReservesOp) }
    its("body.value.sponsored_id") { is_expected.to eq(account.account_id) }
  end

  describe ".end_sponsoring_future_reserves" do
    before { attrs.merge!(source_account: account) }
    subject(:operation) { described_class.end_sponsoring_future_reserves(**attrs) }

    it_behaves_like "XDR serializable"
    its("source_account") { is_expected.to eq(account.muxed_account) }
    its("body.switch.name") { is_expected.to eq("end_sponsoring_future_reserves") }
    its("body.value") { is_expected.to be_nil }
  end

  describe ".revoke_sponsorship" do
    let(:default_params) { {source_account: sponsor, sponsored: account} }

    subject(:operation) do
      described_class.revoke_sponsorship(**default_params)
    end

    shared_examples "Revoke Sponsorship Op" do |*args|
      include_context "XDR serializable"

      its("source_account") { is_expected.to eq(sponsor.muxed_account) }

      current_field, current_type = ["body.value", Stellar::RevokeSponsorshipOp]
      its(current_field) { is_expected.to be_a(current_type) }

      args.each_with_index do |(field, type), index|
        current_field << "." << field.to_s
        current_type = type.is_a?(Module) ? type : current_type.const_get(type)

        its(current_field) { is_expected.to be_a(current_type) }
      end

      it "encodes sponsored account as part of the innermost struct" do
        inner_value = operation.body.value.value.value
        expect(inner_value.to_xdr(:hex)).to include(account.account_id.to_xdr(:hex))
      end
    end

    context "with minimal params" do
      subject(:operation) do
        described_class.revoke_sponsorship(**default_params)
      end

      it_behaves_like "Revoke Sponsorship Op",
        [:ledger_key, Stellar::LedgerKey],
        [:account, "Account"]
    end

    context "with `data_name` param" do
      subject { described_class.revoke_sponsorship(data_name: "My Data Key", **default_params) }
      it_behaves_like "Revoke Sponsorship Op",
        [:ledger_key, Stellar::LedgerKey],
        [:data, "Data"]
    end

    context "with `offer_id` param" do
      subject { described_class.revoke_sponsorship(offer_id: 1234567, **default_params) }

      it_behaves_like "Revoke Sponsorship Op",
        [:ledger_key, Stellar::LedgerKey],
        [:offer, "Offer"]
    end

    context "with `balance_id` param" do
      let(:balance_id) { "62c85d1427571e0514d269ce2384b3baf6c124fbdc5f793fd2409b3c853dc02e" }
      subject { described_class.revoke_sponsorship(balance_id: balance_id, **default_params) }

      it_behaves_like "Revoke Sponsorship Op",
        [:ledger_key, Stellar::LedgerKey],
        [:claimable_balance, "ClaimableBalance"]
    end

    context "with `asset` param" do
      let(:asset) { "TEST-GDQLZTJBZT2KSDYWTS6TGCVSPNG6XXOLBMG3SXVFENASZTPKN4UPNAYV" }
      subject { described_class.revoke_sponsorship(asset: asset, **default_params) }

      it_behaves_like "Revoke Sponsorship Op",
        [:ledger_key, Stellar::LedgerKey],
        [:trust_line, "TrustLine"]
    end

    context "with `signer` param" do
      let(:signer) { "GDQLZTJBZT2KSDYWTS6TGCVSPNG6XXOLBMG3SXVFENASZTPKN4UPNAYV" }
      subject { described_class.revoke_sponsorship(signer: signer, **default_params) }

      it_behaves_like "Revoke Sponsorship Op",
        [:signer, "Signer"],
        [:signer_key, Stellar::SignerKey]
    end
  end
end
