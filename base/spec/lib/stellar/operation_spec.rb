require 'spec_helper'

describe Stellar::Operation, ".payment" do
  it "correctly translates the provided amount to the native representation" do
    op = Stellar::Operation.payment(destination: Stellar::KeyPair.random, amount: [:native, 20])
    expect(op.body.value.amount).to eql(20_0000000)
    op = Stellar::Operation.payment(destination: Stellar::KeyPair.random, amount: [:native, "20"])
    expect(op.body.value.amount).to eql(20_0000000)
  end
end

def pk_to_address(pk)
  Stellar::Convert.pk_to_address(pk)
end

describe "path payment operations" do
  let(:destination){ Stellar::KeyPair.random }
  let(:send_asset_issuer){ Stellar::KeyPair.master }
  let(:send_asset){ Stellar::Asset.alphanum4("USD", send_asset_issuer) }
  let(:dest_asset_issuer){ Stellar::KeyPair.master }
  let(:dest_asset){ Stellar::Asset.alphanum4("EUR", dest_asset_issuer) }
  let(:amount){ [Stellar::Asset.alphanum4(dest_asset.code, dest_asset_issuer), 9.2] }
  let(:with){ [Stellar::Asset.alphanum4(send_asset.code, send_asset_issuer), 10] }
  
  describe Stellar::Operation, ".path_payment" do
    it "works" do
      destination = Stellar::KeyPair.random
      # test both forms of arrays
      amount = [Stellar::Asset.alphanum4("USD", Stellar::KeyPair.master), 10]    
      with = [:alphanum4, "EUR", Stellar::KeyPair.master, 9.2]

      op = Stellar::Operation.path_payment(
        destination: destination,
        amount: amount,
        with: with
      )

      expect(op.body.arm).to eql(:path_payment_strict_receive_op)
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
      expect(op.body.value.destination).to eql(destination.public_key)
      expect(op.body.value.send_asset).to eql(send_asset)
      expect(op.body.value.dest_asset).to eql(dest_asset)
      expect(op.body.value.send_max).to eq(100000000)
      expect(op.body.value.dest_amount).to eq(92000000)
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
      expect(op.body.value.destination).to eql(destination.public_key)
      expect(op.body.value.send_asset).to eql(send_asset)
      expect(op.body.value.dest_asset).to eql(dest_asset)
      expect(op.body.value.send_amount).to eq(100000000)
      expect(op.body.value.dest_min).to eq(92000000)
    end
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
