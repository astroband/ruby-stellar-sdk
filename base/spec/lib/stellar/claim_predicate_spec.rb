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

    context "with nil" do
      let(:timestamp) { nil }

      specify { expect { predicate }.to raise_error(TypeError) }
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

    context "with nil" do
      let(:duration) { nil }
      specify { expect { predicate }.to raise_error(TypeError) }
    end
  end

  describe ".before" do
    subject(:predicate) { described_class.before(arg) }

    context "with a duration" do
      let(:arg) { 1.hour }

      its(:type) { is_expected.to be(Stellar::ClaimPredicateType::BEFORE_RELATIVE_TIME) }
      its(:value) { is_expected.to eq(3600) }
    end

    context "with an integer" do
      let(:arg) { 123456789 }

      its(:type) { is_expected.to be(Stellar::ClaimPredicateType::BEFORE_ABSOLUTE_TIME) }
      its(:value) { is_expected.to eq(123456789) }
    end

    context "with a time-like object" do
      let(:arg) { Time.current }

      its(:type) { is_expected.to be(Stellar::ClaimPredicateType::BEFORE_ABSOLUTE_TIME) }
      its(:value) { is_expected.to eq(arg.to_i) }
    end
  end

  describe ".after" do
    subject(:predicate) { described_class.after(arg) }

    context "with a duration" do
      let(:arg) { 1.hour }

      its(:type) { is_expected.to be(Stellar::ClaimPredicateType::NOT) }
      its(:value) { is_expected.to eq(described_class.before(arg)) }
    end

    context "with an integer" do
      let(:arg) { 123456789 }

      its(:type) { is_expected.to be(Stellar::ClaimPredicateType::NOT) }
      its(:value) { is_expected.to eq(described_class.before(arg)) }
    end

    context "with a time-like object" do
      let(:arg) { Time.current }

      its(:type) { is_expected.to be(Stellar::ClaimPredicateType::NOT) }
      its(:value) { is_expected.to eq(described_class.before(arg)) }
    end
  end

  describe ".compose" do
    subject(:predicate) { described_class.compose { after(15.minutes) & before(1.day) } }

    specify { expect(predicate).to eq(described_class.after(15.minutes).and(described_class.before(1.day))) }
  end

  describe "#and" do
    let(:predicate) { described_class.unconditional }
    let(:other) { described_class.before_relative_time(3600) }

    subject(:call) { predicate.and(other) }

    its(:type) { is_expected.to be(Stellar::ClaimPredicateType::AND) }
    its(:value) { is_expected.to contain_exactly(predicate, other) }

    context "with incorrect arg" do
      let(:other) { "abc" }
      specify { expect { call }.to raise_error(TypeError) }
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
      specify { expect { call }.to raise_error(TypeError) }
    end
  end

  describe "#not" do
    let(:predicate) { described_class.unconditional }

    subject(:call) { predicate.not }

    its(:type) { is_expected.to be(Stellar::ClaimPredicateType::NOT) }
    its(:value) { is_expected.to be(predicate) }
  end

  describe "#evaluate" do
    let(:predicate) { described_class.unconditional }

    def self.specify_claim(created_at:, claimable_at:, not_claimable_at:)
      created_at = created_at.to_time
      subject(:evaluate) { predicate.method(:evaluate) }

      context "with claim created at #{created_at.to_formatted_s(:db)}" do
        let(:created) { created_at.to_time }

        Array(claimable_at).each do |claimed|
          claimed = created_at + claimed if claimed.is_a?(ActiveSupport::Duration)

          it "evaluates to true at #{claimed.to_time.to_formatted_s(:db)}" do
            expect(evaluate.call(created, claimed)).to be_truthy
          end
        end

        Array(not_claimable_at).each do |claimed|
          claimed = created_at + claimed if claimed.is_a?(ActiveSupport::Duration)

          it "evaluates to false at #{claimed.to_time.to_formatted_s(:db)}" do
            expect(evaluate.call(created, claimed)).to be_falsey
          end
        end
      end
    end

    context "unconditional" do
      let(:predicate) { described_class.unconditional }

      specify_claim(
        created_at: "2020-10-20 09:00:00",
        claimable_at: [
          +59.minutes,
          +1.hour,
          +1.day,
          +1.year

        ],
        not_claimable_at: [
          -1.second

        ]
      )
    end

    context "before_relative_time(1.hour)" do
      let(:predicate) { described_class.before_relative_time(1.hour) }

      specify_claim(
        created_at: "2020-10-20 09:00:00",
        claimable_at: [
          "2020-10-20 09:01:00",
          "2020-10-20 09:59:00"
        ],
        not_claimable_at: [
          "2020-10-20 08:59:59",
          "2020-10-20 10:00:00"
        ]
      )
    end

    context "before_absolute_time('2020-10-22 00:00:00')" do
      let(:predicate) { described_class.before_absolute_time("2020-10-22 00:00:00") }

      specify_claim(
        created_at: "2020-10-20 09:00:00",
        claimable_at: [
          "2020-10-20 09:00:00",
          "2020-10-21 23:59:59"
        ],
        not_claimable_at: [
          "2020-10-20 08:59:00",
          "2020-10-22 00:00:00",
          "2021-10-22 09:00:00"
        ]
      )
    end

    context "after(15.minutes) & before(1.day) | after('2020-10-22') & before('2020-10-23')" do
      let(:predicate) do
        described_class.compose {
          after(15.minutes) & before(1.hour) | after("2020-10-22") & before("2020-10-23")
        }
      end

      specify_claim(
        created_at: "2020-10-20 09:00:00",
        claimable_at: [
          "2020-10-20 09:15:00",
          "2020-10-20 09:59:59",
          "2020-10-22 00:00:00",
          "2020-10-22 09:00:00",
          "2020-10-22 23:59:59"
        ],
        not_claimable_at: [
          "2020-10-20 08:59:59",
          "2020-10-20 09:00:00",
          "2020-10-20 09:14:59",
          "2020-10-20 10:00:00",
          "2020-10-21 23:59:59",
          "2020-10-23 00:00:00"
        ]
      )
    end
  end

  describe ".describe" do
    subject(:predicate) {
      described_class.compose {
        after(15.minutes) & before(1.hour) | after("2020-10-22") & before("2020-10-23")
      }
    }

    its(:describe) { is_expected.to eq("(15 minutes or more since creation and less than 1 hour since creation or after 2020-10-22 00:00:00 and before 2020-10-23 00:00:00)") }
  end
end
