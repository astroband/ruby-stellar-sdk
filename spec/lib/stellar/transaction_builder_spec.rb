require "spec_helper"

describe Stellar::TransactionBuilder do
  let(:key_pair){ Stellar::KeyPair.random }
  builder = nil
  before(:each) do
    builder = Stellar::TransactionBuilder.new(
      source_account: key_pair,
      sequence_number: 1
    )
  end

  describe ".initialize" do
    it "bad source_account" do
      expect { 
        Stellar::TransactionBuilder.new(
          source_account: key_pair.account_id,
          sequence_number: 1
        )
      }.to raise_error(
        ArgumentError, "Bad :source_account"
      )
    end
    it "bad sequence_number" do
      expect {
        Stellar::TransactionBuilder.new(
          source_account: key_pair,
          sequence_number: -1
        )
      }.to raise_error(
        ArgumentError, "Bad :sequence_number"
      )
    end
    it "bad timeout" do
      expect {
        Stellar::TransactionBuilder.new(
          source_account: key_pair,
          sequence_number: 1,
          time_bounds: 600
        )
      }.to raise_error(
        ArgumentError, "Bad :time_bounds"
      )
    end
    it "bad base_fee" do
      expect {
        Stellar::TransactionBuilder.new(
          source_account: key_pair,
          sequence_number: 1,
          base_fee: 0
        )
      }.to raise_error(
        ArgumentError, "Bad :base_fee"
      )
    end
    it "bad memo" do
      expect {
        Stellar::TransactionBuilder.new(
          source_account: key_pair,
          sequence_number: 1,
          memo: {"data" => "Testing bad memo"}
        )
      }.to raise_error(
        ArgumentError, "Bad :memo"
      )
    end
    it "success" do
      builder = Stellar::TransactionBuilder.new(
        source_account: key_pair,
        sequence_number: 1,
        time_bounds: Stellar::TimeBounds.new(min_time: 0, max_time: 600),
        base_fee: 200,
        memo: "My test memo"
      )
      expect(builder.memo).to eql(Stellar::Memo.new(:memo_text, "My test memo"))
    end
  end

  describe ".add_operation" do
    it "bad operation" do
      expect { 
        builder.add_operation(
          [:bump_sequence, 1]
        )
      }.to raise_error(
        ArgumentError, "Bad operation"
      )
    end

    it "returns self" do
      expect(builder.add_operation(
          Stellar::Operation.bump_sequence({"bump_to": 1})
      )).to be_an_instance_of(Stellar::TransactionBuilder)
    end
  end

  describe ".clear_operations" do
    it "can clear operations" do
      builder = builder.add_operation(
          Stellar::Operation.bump_sequence({"bump_to": 1})
      ).clear_operations
      expect(builder.operations).to eql([])
    end

    it "returns self" do
      expect(builder.add_operation(
          Stellar::Operation.bump_sequence({"bump_to": 1})
      ).clear_operations).to be_an_instance_of(Stellar::TransactionBuilder)
    end
  end

  describe ".set_sequence_number" do
    it "allows sequence number to be updated" do
      builder.set_sequence_number(5)
      expect(builder.sequence_number).to eql(5)
    end

    it "returns self" do
      expect(builder.set_sequence_number(3)).to be_an_instance_of(Stellar::TransactionBuilder)
    end

    it "raises an error for bad sequence number" do
      expect {
        builder.set_sequence_number(nil) 
      }.to raise_error(
        ArgumentError, "Bad sequence number"
      )
    end
  end

  describe ".set_timeout" do
    it "raises an error for non-integers" do
      expect {
        builder.set_timeout(nil)
      }.to raise_error(
        ArgumentError, "Timeout must be a non-negative integer"
      )
    end

    it "raises an error for negative timeouts" do
      expect {
        builder.set_timeout(-1)
      }.to raise_error(
        ArgumentError, "Timeout must be a non-negative integer"
      )
    end

    it "returns self" do
      expect(builder.set_timeout(10)).to be_an_instance_of(Stellar::TransactionBuilder)
    end
  end

  describe ".set_memo" do
    it "raises an error for bad memos" do
      expect { 
        builder.set_memo({"data" => "Testing bad memo"})
      }.to raise_error(
        ArgumentError, "Bad :memo"
      )
    end

    it "works and returns self" do
      expect(builder.set_memo("Hello").memo).to eql(Stellar::Memo.new(:memo_text, "Hello"))
    end
  end

  describe ".build" do
    it "raises error for time_bounds not set" do
      expect {
        tx = builder.add_operation(
          Stellar::Operation.bump_sequence({"bump_to": 1})
        ).build()
      }.to raise_error(
        RuntimeError, 
        "TransactionBuilder.time_bounds must be set during initialization or by calling set_timeout"
      )
    end

    it "raises an error for non-integer timebounds" do
      builder = Stellar::TransactionBuilder.new(
        source_account: key_pair,
        sequence_number: 1,
        time_bounds: Stellar::TimeBounds.new(min_time: "not", max_time: "integers")
      )
      expect {
        tx = builder.add_operation(
          Stellar::Operation.bump_sequence({"bump_to": 1})
        ).build()
      }.to raise_error(
        RuntimeError, "TimeBounds.min_time and max_time must be Integers"
      )
    end

    it "raises an error for bad TimeBounds range" do
      builder = Stellar::TransactionBuilder.new(
        source_account: key_pair,
        sequence_number: 1,
        time_bounds: Stellar::TimeBounds.new(min_time: Time.now.to_i + 10, max_time: Time.now.to_i)
      )
      expect {
        tx = builder.add_operation(
          Stellar::Operation.bump_sequence({"bump_to": 1})
        ).build()
      }.to raise_error(
        RuntimeError, "Timebounds.max_time must be greater than min_time"
      )
    end

    it "allows max_time to be zero" do
      tx = builder.add_operation(
          Stellar::Operation.bump_sequence({"bump_to": 1})
      ).set_timeout(0).build()
      expect(builder.time_bounds.max_time).to eql(0)
    end

    it "updates sequence number by 1 per build" do
      builder.add_operation(
          Stellar::Operation.bump_sequence({"bump_to": 1})
      ).set_timeout(0).build()
      expect(builder.sequence_number).to eql(2)
    end

    it "creates transaction successfully" do
      bump_op = Stellar::Operation.bump_sequence({"bump_to": 1})
      builder.add_operation(
        Stellar::Operation.bump_sequence({"bump_to": 1})
      ).set_timeout(600).build()
      expect(builder.operations).to eql([bump_op])
    end

    it "allows for multiple transactions to be created" do
      first_max_time = Time.now.to_i + 1000
      bump_op = Stellar::Operation.bump_sequence({"bump_to": 1})
      builder = Stellar::TransactionBuilder.new(
        source_account: key_pair,
        sequence_number: 1,
        time_bounds: Stellar::TimeBounds.new(min_time: 0, max_time: first_max_time)
      )
      tx1 = builder.add_operation(
        Stellar::Operation.bump_sequence({"bump_to": 1})
      ).build()
      expect(tx1.seq_num).to eql(1)
      expect(tx1.operations).to eql([
        Stellar::Operation.bump_sequence({"bump_to": 1})
      ])
      expect(tx1.time_bounds.max_time).to eql(first_max_time)
      
      tx2 = builder.clear_operations.add_operation(
        Stellar::Operation.bump_sequence({"bump_to": 2})
      ).set_timeout(0).build()
      expect(tx2.seq_num).to eql(2)
      expect(tx2.operations).to eql([
        Stellar::Operation.bump_sequence({"bump_to": 2})
      ])
      expect(tx2.time_bounds.max_time).to eql(0)

      expect(builder.sequence_number).to eql(3)
      expect(builder.operations).to eql([
        Stellar::Operation.bump_sequence({"bump_to": 2})
      ])
    end
  end
end