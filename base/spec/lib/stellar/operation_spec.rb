RSpec.shared_examples "XDR serializable" do
  it "roundtrips" do
    base64 = subject.to_xdr(:base64)
    expect(described_class.from_xdr(base64, :base64)).to eq(subject)
  end
end

RSpec.describe Stellar::Operation, ".create_account" do
  let(:funder) { Stellar::KeyPair.random }
  let(:destination) { Stellar::KeyPair.random }
  let(:attrs) { {source_account: funder, destination: destination, starting_balance: 50} }

  subject(:operation) { described_class.create_account(**attrs) }

  it_behaves_like "XDR serializable"

  it "accepts 0 as starting balance" do
    attrs[:starting_balance] = 0
    expect { operation.to_xdr(:base64) }.not_to raise_error
  end

  it "fails when starting balance is missing" do
    attrs.delete(:starting_balance)
    expect { operation.to_xdr(:base64) }.to raise_error(ArgumentError)
  end
end

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
    op = Stellar::Operation.change_trust(asset: asset)
    expect(op.body.value).to be_an_instance_of(Stellar::ChangeTrustOp)
    expect(op.body.value.line).to eq(asset.to_change_trust_asset)
    expect(op.body.value.limit).to eq(9223372036854775807)
  end

  it "creates a ChangeTrustOp with an asset" do
    op = Stellar::Operation.change_trust(asset: asset, limit: 1234.75)
    expect(op.body.value).to be_an_instance_of(Stellar::ChangeTrustOp)
    expect(op.body.value.line).to eq(asset.to_change_trust_asset)
    expect(op.body.value.limit).to eq(12347500000)
  end

  it "only allow sound `line` arguments" do
    expect {
      Stellar::Operation.change_trust(asset: [:harmful_call, "USD", issuer])
    }.to raise_error(TypeError)
  end

  it "creates a ChangeTrustOp with limit" do
    op = Stellar::Operation.change_trust(asset: asset, limit: 1234.75)
    expect(op.body.value).to be_an_instance_of(Stellar::ChangeTrustOp)
    expect(op.body.value.line).to eq(asset.to_change_trust_asset)
    expect(op.body.value.limit).to eq(12347500000)
  end

  it "throws ArgumentError for incorrect limit argument" do
    expect {
      Stellar::Operation.change_trust(asset: Stellar::Asset.alphanum4("USD", issuer), limit: true)
    }.to raise_error(TypeError)
  end
end

RSpec.describe Stellar::Operation, ".set_trust_line_flags" do
  let(:trustor) { Stellar::KeyPair.random }
  let(:asset) { Stellar::Asset.alphanum4("USD", Stellar::KeyPair.master) }
  let(:flags) { {authorized: true, authorized_to_maintain_liabilities: true} }
  let(:attrs) { {trustor: trustor, asset: asset, flags: flags} }

  subject(:operation) { described_class.set_trust_line_flags(**attrs) }

  it_behaves_like "XDR serializable"

  {
    [0, 7] => {authorized: false, authorized_to_maintain_liabilities: false, trustline_clawback_enabled: false},
    [1, 6] => {authorized: true, authorized_to_maintain_liabilities: false, trustline_clawback_enabled: false},
    [2, 5] => {authorized: false, authorized_to_maintain_liabilities: true, trustline_clawback_enabled: false},
    [3, 4] => {authorized: true, authorized_to_maintain_liabilities: true, trustline_clawback_enabled: false},
    [4, 3] => {authorized: false, authorized_to_maintain_liabilities: false, trustline_clawback_enabled: true},
    [5, 2] => {authorized: true, authorized_to_maintain_liabilities: false, trustline_clawback_enabled: true},
    [6, 1] => {authorized: false, authorized_to_maintain_liabilities: true, trustline_clawback_enabled: true},
    [7, 0] => {authorized: true, authorized_to_maintain_liabilities: true, trustline_clawback_enabled: true},
    [1, 0] => {authorized: true},
    [0, 4] => {trustline_clawback_enabled: false}
  }.each do |expected, flags|
    context "when flags are #{flags}" do
      let(:flags) { flags }

      its("body.value.set_flags") { is_expected.to eq(expected[0]) }
      its("body.value.clear_flags") { is_expected.to eq(expected[1]) }
    end
  end
end

RSpec.describe Stellar::Operation, ".manage_buy_offer" do
  let(:buying_issuer) { Stellar::KeyPair.from_address("GDGU5OAPHNPU5UCLE5RDJHG7PXZFQYWKCFOEXSXNMR6KRQRI5T6XXCD7") }
  let(:buying_asset) { Stellar::Asset.alphanum4("USD", buying_issuer) }

  let(:selling_issuer) { Stellar::KeyPair.master }
  let(:selling_asset) { Stellar::Asset.alphanum4("EUR", selling_issuer) }

  it "creates a ManageBuyOfferOp" do
    op = Stellar::Operation.manage_buy_offer(buying: buying_asset, selling: selling_asset, amount: 50, price: 10)
    expect(op.body.value).to be_an_instance_of(Stellar::ManageBuyOfferOp)
    expect(op.body.value.buying).to eq(Stellar::Asset.alphanum4("USD", buying_issuer))
    expect(op.body.value.selling).to eq(Stellar::Asset.alphanum4("EUR", selling_issuer))
    expect(op.body.value.buy_amount).to eq(500000000)
    expect(op.body.value.price.to_d).to eq(10)
  end
end

RSpec.describe Stellar::Operation, ".manage_sell_offer" do
  let(:buying_issuer) { Stellar::KeyPair.from_address("GDGU5OAPHNPU5UCLE5RDJHG7PXZFQYWKCFOEXSXNMR6KRQRI5T6XXCD7") }
  let(:buying_asset) { Stellar::Asset.alphanum4("USD", buying_issuer) }

  let(:selling_issuer) { Stellar::KeyPair.master }
  let(:selling_asset) { Stellar::Asset.alphanum4("EUR", selling_issuer) }

  it "creates a ManageSellOfferOp" do
    op = Stellar::Operation.manage_sell_offer(buying: buying_asset, selling: selling_asset, amount: 50, price: 10)
    expect(op.body.value).to be_an_instance_of(Stellar::ManageSellOfferOp)
    expect(op.body.value.buying).to eq(Stellar::Asset.alphanum4("USD", buying_issuer))
    expect(op.body.value.selling).to eq(Stellar::Asset.alphanum4("EUR", selling_issuer))
    expect(op.body.value.amount).to eq(500000000)
    expect(op.body.value.price.to_d).to eq(10)
  end
end

RSpec.describe Stellar::Operation do
  let(:sponsor) { KeyPair("GCLR75LIUXITGNHSKF7WAEJEWZTIVACKHFMYZTQCP4SKW5MCFXMZODWM") }
  let(:account) { KeyPair("GDQLZTJBZT2KSDYWTS6TGCVSPNG6XXOLBMG3SXVFENASZTPKN4UPNAYV") }
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

    context "with `liquidity_pool_id` param" do
      let(:liquidity_pool_id) { "dd7b1ab831c273310ddbec6f97870aa83c2fbd78ce22aded37ecbf4f3380fac7" }
      subject { described_class.revoke_sponsorship(liquidity_pool_id: liquidity_pool_id, **default_params) }

      it_behaves_like "Revoke Sponsorship Op",
        [:ledger_key, Stellar::LedgerKey],
        [:liquidity_pool, "LiquidityPool"]
    end

    context "with `asset` param" do
      let(:asset) { "TEST-GDQLZTJBZT2KSDYWTS6TGCVSPNG6XXOLBMG3SXVFENASZTPKN4UPNAYV" }
      subject { described_class.revoke_sponsorship(asset: asset, **default_params) }

      it_behaves_like "Revoke Sponsorship Op",
        [:ledger_key, Stellar::LedgerKey],
        [:trust_line, "TrustLine"]
    end

    context "with `data_name` param" do
      subject { described_class.revoke_sponsorship(data_name: "My Data Key", **default_params) }
      it_behaves_like "Revoke Sponsorship Op",
        [:ledger_key, Stellar::LedgerKey],
        [:data, "Data"]
    end

    context "with `signer` param" do
      let(:signer) { "GDQLZTJBZT2KSDYWTS6TGCVSPNG6XXOLBMG3SXVFENASZTPKN4UPNAYV" }
      subject { described_class.revoke_sponsorship(signer: signer, **default_params) }

      it_behaves_like "Revoke Sponsorship Op",
        [:signer, "Signer"],
        [:signer_key, Stellar::SignerKey]
    end
  end

  describe ".clawback" do
    let(:asset) { Stellar::Asset.alphanum4("USD", account) }
    let(:amount) { 1 }
    let(:from) { Stellar::KeyPair.random }
    let(:attrs) do
      {
        source_account: account,
        from: from,
        amount: [asset, amount]
      }
    end
    subject(:operation) { described_class.clawback(**attrs) }

    it_behaves_like "XDR serializable"

    its("body.value") { is_expected.to be_a(Stellar::ClawbackOp) }
    its("body.value.from") { is_expected.to eq(from.muxed_account) }
    its("body.value.amount") { is_expected.to eq(amount * 10_000_000) }
    its("body.switch.name") { is_expected.to eq("clawback") }

    its("source_account") { is_expected.to eq(account.muxed_account) }

    context "when amount is zero" do
      let(:amount) { 0 }

      it "raises an error" do
        expect { operation }.to raise_error(ArgumentError, "Amount can not be zero")
      end
    end

    context "when amount is negative" do
      let(:amount) { "-100" }

      it "raises an error" do
        expect { operation }.to raise_error(ArgumentError, "Negative amount is not allowed")
      end
    end
  end

  describe ".clawback_claimable_balance" do
    let(:balance_id) do
      # hex representation, taken from testnet Horizon
      "00000000c15f7ff639f26e92d3924f46e040a8e85812534af9a2e8886cb6fbf821fdd6ed"
    end

    let(:attrs) do
      {
        source_account: account,
        balance_id: balance_id
      }
    end
    subject(:operation) { described_class.clawback_claimable_balance(**attrs) }

    it_behaves_like "XDR serializable"

    its("body.value") { is_expected.to be_a(Stellar::ClawbackClaimableBalanceOp) }
    its("body.value.balance_id") { is_expected.to be_a(Stellar::ClaimableBalanceID) }

    it "sets balance_id properly" do
      hex_balance_id = operation.body.value.balance_id.to_xdr(:hex)

      expect(hex_balance_id).to eq(balance_id)
    end

    its("source_account") { is_expected.to eq(account.muxed_account) }

    context "when invalid balance id is provided" do
      let(:balance_id) { "someinvalidstring" }

      it "raises error" do
        expect { operation }.to raise_error(ArgumentError, "Claimable balance id '#{balance_id}' is invalid")
      end
    end
  end
end
