RSpec.describe Stellar::ClaimPredicate do
  describe ".unconditional" do
    subject { described_class.unconditional }

    it { is_expected.to be_a(Stellar::ClaimPredicate) }
    its(:type) { is_expected.to be(Stellar::ClaimPredicateType::UNCONDITIONAL) }
    its(:value) { is_expected.to be_nil }
  end

  describe ".before_absolute_time" do
    let(:timestamp) { 123456789 }
    subject(:predicate) { described_class.before_absolute_time(timestamp) }

    it { is_expected.to be_a(Stellar::ClaimPredicate) }
    its(:type) { is_expected.to be(Stellar::ClaimPredicateType::BEFORE_ABSOLUTE_TIME) }
    its(:value) { is_expected.to eq(123456789) }

    context "with incorrect args" do
      let(:timestamp) { "abc" }
      specify { expect { predicate }.to raise_error(ArgumentError) }
    end
  end

  describe ".before_relative_time" do
    let(:duration) { 3600 }
    subject(:predicate) { described_class.before_relative_time(duration) }

    its(:type) { is_expected.to be(Stellar::ClaimPredicateType::BEFORE_RELATIVE_TIME) }
    its(:value) { is_expected.to eq(3600) }

    context "with incorrect args" do
      let(:duration) { "abc" }
      specify { expect { predicate }.to raise_error(ArgumentError) }
    end
  end

  describe "#and" do
    let(:predicate) { described_class.unconditional }
    let(:other) { described_class.before_relative_time(3600) }

    subject(:call) { predicate.and(other) }

    its(:type) { is_expected.to be(Stellar::ClaimPredicateType::AND) }
    its(:value) { is_expected.to contain_exactly(predicate, other) }

    context "with incorrect arg" do
      let(:other) { "abc" }
      specify { expect { call }.to raise_error(ArgumentError) }
    end
  end

  describe "#or" do
    let(:predicate) { described_class.unconditional }
    let(:other) { described_class.before_relative_time(3600) }

    subject(:call) { predicate.or(other) }

    its(:type) { is_expected.to be(Stellar::ClaimPredicateType::OR) }
    its(:value) { is_expected.to contain_exactly(predicate, other) }

    context "with incorrect arg" do
      let(:other) { "abc" }
      specify { expect { call }.to raise_error(ArgumentError) }
    end
  end

  describe "#not" do
    let(:predicate) { described_class.unconditional }

    subject(:call) { predicate.not }

    its(:type) { is_expected.to be(Stellar::ClaimPredicateType::NOT) }
    its(:value) { is_expected.to be(predicate) }
  end
end
