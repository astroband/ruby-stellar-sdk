require "spec_helper"

describe Stellar, ".default_network=" do

  before(:each){ Stellar.default_network = "foo" }
  after(:each){ Stellar.default_network = nil }

  it "sets the value returned by current_network " do
    expect(Stellar.current_network).to eql("foo")
  end

end

describe Stellar, ".current_network" do

  after(:each){ Stellar.default_network = nil }

  it "returns the public network absent any other configuration" do
    expect(Stellar.current_network).to eql(Stellar::Networks::TESTNET)
  end

  it "returns the default network if configured and not within a call to on_network" do
    Stellar.default_network = "foo"
    expect(Stellar.current_network).to eql("foo")
  end

  it "returns the network as specified by on_network, even when a default is set" do
    Stellar.default_network = "foo"

    Stellar.on_network "bar" do
      expect(Stellar.current_network).to eql("bar")
    end

    expect(Stellar.current_network).to eql("foo")
  end
end

describe Stellar, ".current_network_id" do
  it "returns the sha256 of the current_network" do
    expect(Stellar.current_network_id).to eql(Digest::SHA256.digest(Stellar.current_network))
  end
end

describe Stellar, ".on_network" do

  after(:each){ Thread.current["stellar_network_passphrase"] = nil }


  it "sets the current_network and a thread local" do
    Stellar.on_network "bar" do
      expect(Stellar.current_network).to eql("bar")
      expect(Thread.current["stellar_network_passphrase"]).to eql("bar")
    end
  end


  it "nests" do
    Stellar.on_network "foo" do
      expect(Stellar.current_network).to eql("foo")
      Stellar.on_network "bar" do
        expect(Stellar.current_network).to eql("bar")
      end
      expect(Stellar.current_network).to eql("foo")
    end
  end


  it "resets the network value when an error is raised" do
    begin
      Stellar.on_network "foo" do
        raise "kablow"
      end
    rescue
      expect(Stellar.current_network).to_not eql("foo")
    end
  end
end
