require "spec_helper"

describe Stellar::Client do
  subject(:client) { Stellar::Client.default_testnet }

  describe "#payments" do
    let(:account) { Stellar::Account.from_address('GD4SAUKGB6GE2Q25H2CZMZ3BSP5CVYIY2LQYJDCFNNICR473AVL7IYH5') }
    let(:cursor) { '22379674420121606' }
    let(:ledger) { '9356704' }
    let(:transaction) { '96c6728f71e8dafc1a9ee85286f0e0f0773cc6f2b1d54dfd891477006f294e71' }

    it "returns the list of payments", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.payments
      expect(response).to be_a(Stellar::PaymentPage)
    end

    it "accepts account as parameter", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.payments(account: account)
      expect(response).to be_a(Stellar::PaymentPage)
    end

    it "accepts cursor as parameter", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.payments(cursor: cursor)
      expect(response).to be_a(Stellar::PaymentPage)
    end

    it "accepts ledger as parameter", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.payments(ledger: ledger)
      expect(response).to be_a(Stellar::PaymentPage)
    end

    it "accepts limit as parameter", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.payments(limit: 8)
      expect(response).to be_a(Stellar::PaymentPage)
    end

    it "accepts transaction as parameter", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.payments(transaction: transaction)
      expect(response).to be_a(Stellar::PaymentPage)
    end

    it "allows user to traverse payments", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.payments(limit: 2)
      response.each do |payment|
        expect(payment).to respond_to(:created_at, :transaction_hash, :type, :type_i)
      end
    end

    context "next_page" do
      it "allows user to call #next_page", vcr: {record: :once, match_requests_on: [:method]} do
        response = client.payments(limit: 2).next_page
        expect(response).to be_a(Stellar::PaymentPage)
      end

      it "allows user to call #next_page!", vcr: {record: :once, match_requests_on: [:method]} do
        response = client.payments(limit: 2)
        response.next_page!
        expect(response).to be_a(Stellar::PaymentPage)
      end
    end

  end
end
