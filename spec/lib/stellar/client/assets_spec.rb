require "spec_helper"

describe Stellar::Client do
  subject(:client) { Stellar::Client.default_testnet }

  describe "#assets" do
    let(:asset_issuer) { Stellar::Account.from_address('GD4SAUKGB6GE2Q25H2CZMZ3BSP5CVYIY2LQYJDCFNNICR473AVL7IYH5') }
    let(:cursor) { '00897b_GD4SAUKGB6GE2Q25H2CZMZ3BSP5CVYIY2LQYJDCFNNICR473AVL7IYH5_credit_alphanum12' }

    it "returns the list of assets", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.assets
      expect(response).to be_a(Stellar::AssetPage)
    end

    it "accepts asset_code as parameter", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.assets(asset_code: 'XLM')
      expect(response).to be_a(Stellar::AssetPage)
    end

    it "accepts asset_issuer as parameter", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.assets(asset_issuer: asset_issuer)
      expect(response).to be_a(Stellar::AssetPage)
    end

    it "accepts cursor as parameter", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.assets(cursor: cursor)
      expect(response).to be_a(Stellar::AssetPage)
    end

    it "accepts limit as parameter", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.assets(limit: 8)
      expect(response).to be_a(Stellar::AssetPage)
    end

    it "allows user to traverse assets", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.assets(limit: 2)
      response.each do |asset|
        expect(asset).to respond_to(:amount, :asset_type, :asset_code, :asset_issuer, :flags,
          :paging_token, :num_accounts)
      end
    end

    context "next_page" do
      it "allows user to call #next_page", vcr: {record: :once, match_requests_on: [:method]} do
        response = client.assets(limit: 2).next_page
        expect(response).to be_a(Stellar::AssetPage)
      end

      it "allows user to call #next_page!", vcr: {record: :once, match_requests_on: [:method]} do
        response = client.assets(limit: 2)
        response.next_page!
        expect(response).to be_a(Stellar::AssetPage)
      end
    end

  end
end
