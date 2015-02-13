require "spec_helper"

describe Stellar::Transaction, "#sign" do
  subject do
    Stellar::Transaction.new({
      account:    "\x00" * 32,
      max_fee:    10,
      seq_num:    1,
      max_ledger: 10,
      min_ledger: 0,
      body:       Stellar::Transaction::Body.new(:cancel_offer, 1)
    })
  end

  let(:key_pair){ Stellar::KeyPair.random }
  let(:result){ subject.sign(key_pair) }


  it "returns a signature of the xdr form of the transaction" do
    xdr      = subject.to_xdr
    expected = key_pair.sign(xdr)
    expect(result).to eq(expected)
  end
end

describe Stellar::Transaction, "#to_envelope" do
  
  it "return a Stellar::TransactionEnvelope"
  it "correctly signs the transaction"
end