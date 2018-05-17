require 'spec_helper'

describe Stellar::Operation, ".payment" do


  it "correctly translates the provided amount to the native representation" do
    op = Stellar::Operation.payment(destination: Stellar::KeyPair.random, amount: [:native, 20])
    expect(op.body.value.amount).to eql(20_0000000)
    op = Stellar::Operation.payment(destination: Stellar::KeyPair.random, amount: [:native, "20"])
    expect(op.body.value.amount).to eql(20_0000000)
  end

end


describe Stellar::Operation, ".manage_data" do

  it "works" do
    op = Stellar::Operation.manage_data(name: "my name", value: "hello")
    expect(op.body.manage_data_op!.data_name).to eql("my name")
    expect(op.body.manage_data_op!.data_value).to eql("hello")
    expect{ op.to_xdr }.to_not raise_error

    op = Stellar::Operation.manage_data(name: "my name")
    expect(op.body.manage_data_op!.data_name).to eql("my name")
    expect(op.body.manage_data_op!.data_value).to be_nil
    expect{ op.to_xdr }.to_not raise_error
  end

end

describe Stellar::Operation, ".change_trust" do

  let(:issuer) { Stellar::KeyPair.from_address("GDGU5OAPHNPU5UCLE5RDJHG7PXZFQYWKCFOEXSXNMR6KRQRI5T6XXCD7") }
  let(:asset) { Stellar::Asset.alphanum4("USD", issuer) }

  it "creates a ChangeTrustOp" do
    op = Stellar::Operation.change_trust(line: [:alphanum4, "USD", issuer])
    expect(op.body.value).to be_an_instance_of(Stellar::ChangeTrustOp)
    expect(op.body.value.line).to eq(Stellar::Asset.alphanum4("USD", issuer))
    expect(op.body.value.limit).to eq(9223372036854775807)
  end

  it "only allow sound `line` arguments" do
    expect {
      Stellar::Operation.change_trust(line: [:harmful_call, "USD", issuer])
    }.to raise_error(ArgumentError, "must be one of #{Stellar::Asset::TYPES}")
  end

  it "creates a ChangeTrustOp with limit" do
    op = Stellar::Operation.change_trust(line: [:alphanum4, "USD", issuer], limit: 1234.75)
    expect(op.body.value).to be_an_instance_of(Stellar::ChangeTrustOp)
    expect(op.body.value.line).to eq(Stellar::Asset.alphanum4("USD", issuer))
    expect(op.body.value.limit).to eq(12347500000)
  end

  it "throws ArgumentError for incorrect limit argument" do
    expect {
      Stellar::Operation.change_trust(line: [:alphanum4, "USD", issuer], limit: true)
    }.to raise_error(ArgumentError)
  end

end
