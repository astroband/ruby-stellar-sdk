require 'spec_helper'

describe Stellar::Client do
  subject(:client) { Stellar::Client.default_testnet }

  describe '#trades' do
    let(:cursor) { '40354490511003649-0' }
    let(:offer_id) { 430_699 }

    it 'returns the list of trades', vcr: { record: :once, match_requests_on: [:method] } do
      response = client.trades
      expect(response).to be_a(Stellar::TradePage)
    end

    it 'accepts account as parameter'

    it 'accepts base and counter asset parameters', vcr: { record: :once, match_requests_on: [:method] } do
      response = client.trades(base_asset_code: 'BTC',
                               base_asset_issuer: 'GA77B6GK5K3FH2YJ6I5VJ7VPFZKPBQUX2IIC2MJYAERQTGJI4VOPKRYJ',
                               base_asset_type: 'credit_alphanum4',
                               counter_asset_code: 'LTC',
                               counter_asset_issuer: 'GA77B6GK5K3FH2YJ6I5VJ7VPFZKPBQUX2IIC2MJYAERQTGJI4VOPKRYJ',
                               counter_asset_type: 'credit_alphanum4')
      expect(response).to be_a(Stellar::TradePage)
    end

    it 'accepts cursor as parameter', vcr: { record: :once, match_requests_on: [:method] } do
      response = client.trades(cursor: cursor)
      expect(response).to be_a(Stellar::TradePage)
    end

    it 'accepts limit as parameter', vcr: { record: :once, match_requests_on: [:method] } do
      response = client.trades(limit: 2)
      expect(response).to be_a(Stellar::TradePage)
    end

    it 'accepts offer_id as parameter', vcr: { record: :once, match_requests_on: [:method] } do
      response = client.trades(offer_id: offer_id)
      expect(response).to be_a(Stellar::TradePage)
    end

    it 'accepts order as parameter', vcr: { record: :once, match_requests_on: [:method] } do
      response = client.trades(order: 'desc')
      expect(response).to be_a(Stellar::TradePage)
    end

    it 'allows user to traverse trades', vcr: {record: :once, match_requests_on: [:method]} do
      response = client.trades(limit: 2)
      response.each do |trade|
        expect(trade).to respond_to(:id, :paging_token, :ledger_close_time, :offer_id, :base_account, :base_amount,
                                    :base_asset_type, :counter_account, :counter_amount, :counter_asset_type,
                                    :base_is_seller, :price)
      end
    end

    context 'next_page' do
      it 'allows user to call #next_page', vcr: { record: :once, match_requests_on: [:method] } do
        response = client.trades(limit: 2).next_page
        expect(response).to be_a(Stellar::TradePage)
      end

      it 'allows user to call #next_page!', vcr: { record: :once, match_requests_on: [:method] } do
        response = client.trades(limit: 2)
        response.next_page!
        expect(response).to be_a(Stellar::TradePage)
      end
    end
  end
end
