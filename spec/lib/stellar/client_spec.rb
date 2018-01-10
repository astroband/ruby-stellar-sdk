require "spec_helper"

describe Stellar::Client do

  subject(:client) { Stellar::Client.default_testnet }

  describe "#create_account" do
    let(:funder) { Stellar::Account.from_seed(CONFIG[:funded_seed]) }
    let(:account) { Stellar::Account.random }

    it "creates the account", vcr: {record: :once, match_requests_on: [:method]} do
      client.create_account(
        funder: funder,
        account: account,
        starting_balance: 100,
      )

      account_info = client.account_info(account)
      balances = account_info.balances
      expect(balances).to_not be_empty
      native_asset_balance_info = balances.find do |b|
        b["asset_type"] == "native"
      end
      expect(native_asset_balance_info["balance"].to_f).to eq 100.0
    end
  end

  describe "#send_payment" do
    let(:funder) { Stellar::Account.from_seed(CONFIG[:funded_seed]) }
    let(:account) { Stellar::Account.random }

    it "sends a payment to the account", vcr: {record: :once, match_requests_on: [:method]} do
      client.create_account(
        funder: funder,
        account: account,
        starting_balance: 100,
      )

      amount = Stellar::Amount.new(150)

      client.send_payment(
        from: funder,
        to: account,
        amount: amount,
      )

      account_info = client.account_info(account)
      balances = account_info.balances
      expect(balances).to_not be_empty
      native_asset_balance_info = balances.find do |b|
        b["asset_type"] == "native"
      end
      expect(native_asset_balance_info["balance"].to_f).to eq 250.0
    end
  end

end
