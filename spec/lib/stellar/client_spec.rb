require "spec_helper"

describe Stellar::Client do

  subject(:client) { Stellar::Client.default_testnet }

  describe "#create_account" do
    let(:funder) { Stellar::Account.from_seed(CONFIG[:funded_seed]) }
    let(:account) { Stellar::Account.random }

    it "creates the account", vcr: {record: :once} do
      client.create_account(
        funder: funder,
        account: account,
        starting_balance: 100,
      )
    end
  end

end
