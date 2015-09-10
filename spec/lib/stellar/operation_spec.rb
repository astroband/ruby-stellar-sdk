require 'spec_helper'

describe Stellar::Operation, ".payment" do


  it "correctly translates the provided amount to the native representation" do
    op = Stellar::Operation.payment(destination: Stellar::KeyPair.random, amount: [:native, 20])
    expect(op.body.value.amount).to eql(20_0000000) 
    op = Stellar::Operation.payment(destination: Stellar::KeyPair.random, amount: [:native, "20"])
    expect(op.body.value.amount).to eql(20_0000000) 
  end

end
