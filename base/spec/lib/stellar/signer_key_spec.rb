require "spec_helper"

describe Stellar::SignerKey, ".hash_x" do

  subject{ Stellar::SignerKey }

  let(:hash_preimage){ "a" * 32 }
  let(:hash){ Digest::SHA256.digest(hash_preimage) }

  it "raises an argument error when not provided a 32-byte string" do
    expect{subject.hash_x("hello world")}.to raise_error(ArgumentError)
    expect{subject.hash_x("")}.to raise_error(ArgumentError)
    expect{subject.hash_x("a" * 31)}.to raise_error(ArgumentError)
    expect{subject.hash_x("a" * 33)}.to raise_error(ArgumentError)
    expect{subject.hash_x([0] * 32)}.to raise_error(ArgumentError)

  end

  it "creates a HashX signer key" do
    sk = subject.hash_x(hash_preimage)
    expect(sk.switch).to eq(Stellar::SignerKeyType.signer_key_type_hash_x)
    expect(sk.value).to be_an_instance_of(String)
    expect(sk.value).to eq(hash)
  end

end
