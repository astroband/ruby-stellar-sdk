require "spec_helper"

describe Stellar::Thresholds, ".parse" do
  subject { Stellar::Thresholds }
  let(:raw) { "\x01\x02\x03\x04" }
  let(:result) { subject.parse raw }

  it "sets master_weight as the 1st byte" do
    expect(result[:master_weight]).to eq(1)
  end

  it "sets low as the 2nd byte" do
    expect(result[:low]).to eq(2)
  end

  it "sets medium as the 3rd byte" do
    expect(result[:medium]).to eq(3)
  end

  it "sets high as the 4th byte" do
    expect(result[:high]).to eq(4)
  end
end

describe Stellar::Thresholds, ".make" do
  subject { Stellar::Thresholds }
  let(:good) { {master_weight: 1, low: 2, medium: 3, high: 4} }

  it "works" do
    expect(subject.make(good)).to eq("\x01\x02\x03\x04")
  end

  it "errors unless all components are provided" do
    expect { subject.make(good.except(:master_weight)) }.to raise_error(ArgumentError)
    expect { subject.make(good.except(:low)) }.to raise_error(ArgumentError)
    expect { subject.make(good.except(:medium)) }.to raise_error(ArgumentError)
    expect { subject.make(good.except(:high)) }.to raise_error(ArgumentError)
  end

  it "errors unless all components are numbers" do
    expect { subject.make(good.merge(master_weight: "hello")) }.to raise_error(ArgumentError)
    expect { subject.make(good.merge(low: "hello")) }.to raise_error(ArgumentError)
    expect { subject.make(good.merge(medium: "hello")) }.to raise_error(ArgumentError)
    expect { subject.make(good.merge(high: "hello")) }.to raise_error(ArgumentError)
  end

  it "errors unless all components are in (0..255)" do
    expect { subject.make(good.merge(master_weight: -1)) }.to raise_error(ArgumentError)
    expect { subject.make(good.merge(master_weight: 256)) }.to raise_error(ArgumentError)
    expect { subject.make(good.merge(low: -1)) }.to raise_error(ArgumentError)
    expect { subject.make(good.merge(low: 256)) }.to raise_error(ArgumentError)
    expect { subject.make(good.merge(medium: -1)) }.to raise_error(ArgumentError)
    expect { subject.make(good.merge(medium: 256)) }.to raise_error(ArgumentError)
    expect { subject.make(good.merge(high: -1)) }.to raise_error(ArgumentError)
    expect { subject.make(good.merge(high: 256)) }.to raise_error(ArgumentError)
  end

  it "ignores additional keys" do
    expect { subject.make(good.merge(foo: "a string")) }.not_to raise_error
  end
end
