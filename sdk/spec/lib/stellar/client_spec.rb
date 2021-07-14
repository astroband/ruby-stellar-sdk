RSpec.describe Stellar::Client do
  subject(:client) { Stellar::Client.default_testnet }

  describe "headers" do
    let(:headers) { client.horizon.headers }

    it "has 'Accept'" do
      expect(headers["Accept"])
        .to eq "application/hal+json,application/problem+json,application/json"
    end

    it "has 'X-Client-Name'" do
      expect(headers["X-Client-Name"]).to eq "ruby-stellar-sdk"
    end

    it "has 'X-Client-Version'" do
      expect(headers["X-Client-Version"]).to eq Stellar::VERSION
    end
  end

  describe "#default_testnet" do
    it "instantiates a client pointing to horizon testnet" do
      client = described_class.default_testnet
      expect(client.horizon._url).to eq(described_class::HORIZON_TESTNET_URL)
    end
  end

  describe "#default" do
    it "instantiates a client pointing to horizon mainnet" do
      client = described_class.default
      expect(client.horizon._url).to eq(described_class::HORIZON_MAINNET_URL)
    end
  end

  describe "#localhost" do
    it "instantiates a client pointing to localhost horizon" do
      client = described_class.localhost
      expect(client.horizon._url).to eq(described_class::HORIZON_LOCALHOST_URL)
    end
  end

  describe "#initialize" do
    let(:custom_horizon_url) { "https://horizon.domain.com" }
    it "instantiates a client accepting custom options" do
      client = described_class.new(horizon: custom_horizon_url)
      expect(client.horizon._url).to eq(custom_horizon_url)
    end
  end

  describe "#friendbot" do
    let(:client) { Stellar::Client.default_testnet }
    let(:account) { Stellar::Account.random }

    it("requests for XLM from a friendbot", {
      vcr: {record: :once, match_requests_on: [:method]}
    }) do
      response = client.friendbot(account)

      expect(response).to be_success

      destination_info = client.account_info(account)
      balances = destination_info.balances
      expect(balances).to_not be_empty
      native_asset_balance_info = balances.find { |b|
        b["asset_type"] == "native"
      }
      expect(native_asset_balance_info["balance"].to_f).to be > 0
    end
  end

  describe "#create_account" do
    let(:source) { Stellar::Account.from_seed(CONFIG[:source_seed]) }
    let(:destination) { Stellar::Account.random }

    it "creates the account", vcr: {record: :once, match_requests_on: [:method]} do
      client.create_account(
        funder: source,
        account: destination,
        starting_balance: 100
      )

      destination_info = client.account_info(destination)
      balances = destination_info.balances
      expect(balances).to_not be_empty
      native_asset_balance_info = balances.find { |b|
        b["asset_type"] == "native"
      }
      expect(native_asset_balance_info["balance"].to_f).to eq 100.0
    end
  end

  describe "#account_info" do
    let(:account) { Stellar::Account.from_seed(CONFIG[:source_seed]) }
    let(:client) { Stellar::Client.default_testnet }

    it "returns the current details for the account", vcr: {record: :once, match_requests_on: [:method]} do
      response = client.account_info(account)

      expect(response.id).to eq CONFIG[:source_address]
      expect(response.paging_token).to be_empty
      expect(response.sequence).to eq "346973227974715"
      expect(response.subentry_count).to eq 0
      expect(response.thresholds).to include("low_threshold" => 0, "med_threshold" => 0, "high_threshold" => 0)
      expect(response.flags).to include("auth_required" => false, "auth_revocable" => false)
      expect(response.balances).to include("balance" => "3494.9997500", "asset_type" => "native")
      expect(response.signers).to include(
        "public_key" => CONFIG[:source_address],
        "weight" => 1,
        "type" => "ed25519_public_key",
        "key" => CONFIG[:source_address]
      )
      expect(response.data).to be_empty
    end
  end

  describe "#account_merge" do
    let(:funder) { Stellar::Account.from_seed(CONFIG[:source_seed]) }
    let(:client) { Stellar::Client.default_testnet }
    let(:source) { Stellar::Account.random }
    let(:destination) { Stellar::Account.random }

    it "merges source account into destination", vcr: {record: :once, match_requests_on: [:method]} do
      [source, destination].each do |account|
        client.create_account(
          funder: funder,
          account: account,
          starting_balance: 100
        )
      end

      client.account_merge(
        account: source,
        destination: destination
      )

      destination_info = client.account_info(destination)
      native_asset_balance_info = destination_info.balances.find { |b|
        b["asset_type"] == "native"
      }
      # balance of merged account is the balance of both accounts minus transaction fee for merge
      expect(native_asset_balance_info["balance"].to_f).to eq 199.99999
    end
  end

  describe "#send_payment" do
    let(:source) { Stellar::Account.from_seed(CONFIG[:source_seed]) }

    context "native asset" do
      let(:destination) { Stellar::Account.random }

      it "sends a native payment to the account", vcr: {record: :once, match_requests_on: [:method]} do
        client.create_account(
          funder: source,
          account: destination,
          starting_balance: 100
        )

        amount = Stellar::Amount.new(150)

        client.send_payment(
          from: source,
          to: destination,
          amount: amount
        )

        destination_info = client.account_info(destination)
        balances = destination_info.balances
        expect(balances).to_not be_empty
        native_asset_balance_info = balances.find { |b|
          b["asset_type"] == "native"
        }
        expect(native_asset_balance_info["balance"].to_f).to eq 250.0
      end
    end

    context "alphanum4 asset" do
      let(:issuer) { Stellar::Account.from_seed(CONFIG[:source_seed]) }
      let(:destination) { Stellar::Account.random }

      it("sends a alphanum4 asset to the destination", {
        vcr: {record: :once, match_requests_on: [:method]}
      }) do
        client.create_account(
          funder: issuer,
          account: destination,
          starting_balance: 2
        )

        client.change_trust(
          asset: [:alphanum4, "BTC", issuer.keypair],
          source: destination
        )

        asset = Stellar::Asset.alphanum4("BTC", source.keypair)
        amount = Stellar::Amount.new(150, asset)
        client.send_payment(
          from: source,
          to: destination,
          amount: amount
        )

        destination_info = client.account_info(destination)
        btc_balance = destination_info.balances.find { |b|
          b["asset_code"] == "BTC"
        }["balance"].to_f

        expect(btc_balance).to eq 150.0
      end
    end

    context "alphanum12 asset" do
      let(:issuer) { Stellar::Account.from_seed(CONFIG[:source_seed]) }
      let(:destination) { Stellar::Account.random }

      it("sends a alphanum12 asset to the destination", {
        vcr: {record: :once, match_requests_on: [:method]}
      }) do
        client.create_account(
          funder: issuer,
          account: destination,
          starting_balance: 2
        )

        client.change_trust(
          asset: [:alphanum12, "LONGNAME", issuer.keypair],
          source: destination
        )

        asset = Stellar::Asset.alphanum12("LONGNAME", source.keypair)
        amount = Stellar::Amount.new(150, asset)

        client.send_payment(
          from: source,
          to: destination,
          amount: amount
        )

        destination_info = client.account_info(destination)
        btc_balance = destination_info.balances.find { |b|
          b["asset_code"] == "LONGNAME"
        }["balance"].to_f

        expect(btc_balance).to eq 150.0
      end
    end

    context "memo" do
      let(:destination) { Stellar::Account.random }

      it("accepts the memo attribute", {
        vcr: {record: :once, match_requests_on: [:method]}
      }) do
        client.create_account(
          funder: source,
          account: destination,
          starting_balance: 100
        )

        amount = Stellar::Amount.new(150)

        client.send_payment(
          from: source,
          to: destination,
          amount: amount,
          memo: "DESUKA"
        )

        last_tx = client.account_info(destination)
          .transactions(order: "desc")._get._embedded.records.first
        expect(last_tx.memo).to eq "DESUKA"
      end
    end

    context "using a payment channel" do
      let(:transaction_source) { Stellar::Account.from_seed(CONFIG[:channel_seed]) }
      let(:destination) { Stellar::Account.random }

      it("sends a payment account through a channel account", {
        vcr: {record: :once, match_requests_on: [:method]}
      }) do
        client.create_account(
          funder: source,
          account: destination,
          starting_balance: 1
        )

        tx = client.send_payment(
          from: source,
          to: destination,
          amount: Stellar::Amount.new(0.55),
          transaction_source: transaction_source
        )

        tx_hash = tx._attributes["hash"]

        tx = client.horizon.transaction(hash: tx_hash)
        expect(tx.source_account).to eq transaction_source.address

        operation = tx.operations.records.first
        expect(operation.from).to eq source.address

        destination_info = client.account_info(destination)
        balances = destination_info.balances
        expect(balances).to_not be_empty
        native_asset_balance_info = balances.find { |b|
          b["asset_type"] == "native"
        }
        expect(native_asset_balance_info["balance"].to_f).to eq 1.55
      end

      it("sends a payment when the channel is the same as `from`", {
        vcr: {record: :once, match_requests_on: [:method]}
      }) do
        client.create_account(
          funder: source,
          account: destination,
          starting_balance: 1
        )

        tx = client.send_payment(
          from: source,
          to: destination,
          amount: Stellar::Amount.new(0.55),
          transaction_source: source
        )

        tx_hash = tx._attributes["hash"]

        tx = client.horizon.transaction(hash: tx_hash)
        expect(tx.source_account).to eq source.address

        operation = tx.operations.records.first
        expect(operation.from).to eq source.address
      end
    end
  end

  describe "#transactions" do
    let(:cursor) { "348403452088320" }

    context "account transactions" do
      let(:account) { Stellar::Account.from_seed(CONFIG[:source_seed]) }

      it "returns a list of transaction for an account", vcr: {record: :once, match_requests_on: [:method]} do
        response = client.transactions(account: account)
        expect(response).to be_a(Stellar::TransactionPage)
      end

      it "accepts a cursor to return less data", vcr: {record: :once, match_requests_on: [:method]} do
        response = client.transactions(account: account, cursor: cursor)
        expect(response).to be_a(Stellar::TransactionPage)
      end
    end

    context "all transactions" do
      it "returns a list of transactions", vcr: {record: :once, match_requests_on: [:method]} do
        response = client.transactions
        expect(response).to be_a(Stellar::TransactionPage)
      end

      it "accepts a cursor to return less data", vcr: {record: :once, match_requests_on: [:method]} do
        response = client.transactions(cursor: cursor)
        expect(response).to be_a(Stellar::TransactionPage)
      end
    end
  end

  describe "#change_trust" do
    context "given an asset described as an array" do
      let(:issuer) { Stellar::Account.from_seed(CONFIG[:source_seed]) }
      let(:truster) { Stellar::Account.random }

      it("creates, updates, or deletes a trustline", {
        vcr: {record: :once, match_requests_on: [:method]}
      }) do
        client.create_account(
          funder: issuer,
          account: truster,
          starting_balance: 2
        )

        # Create trustline
        client.change_trust(
          asset: [:alphanum4, "BTC", issuer.keypair],
          source: truster
        )

        truster_info = client.account_info(truster)
        btc_balance = truster_info.balances.find { |b|
          b["asset_code"] == "BTC" && b["asset_issuer"] == issuer.address
        }

        expect(btc_balance).to_not be_nil

        # Update trustline
        client.change_trust(
          asset: [:alphanum4, "BTC", issuer.keypair],
          source: truster,
          limit: 100
        )

        truster_info = client.account_info(truster)
        btc_balance = truster_info.balances.find { |b|
          b["asset_code"] == "BTC" && b["asset_issuer"] == issuer.address
        }

        expect(btc_balance["limit"].to_f).to eq 100

        # Delete trustline
        client.change_trust(
          asset: [:alphanum4, "BTC", issuer.keypair],
          source: truster,
          limit: 0
        )

        truster_info = client.account_info(truster)
        btc_balance = truster_info.balances.find { |b|
          b["asset_code"] == "BTC" && b["asset_issuer"] == issuer.address
        }

        expect(btc_balance).to be_nil
      end
    end
  end

  describe "#submit_transaction" do
    let(:kp) { Stellar::KeyPair.from_seed("SA27TR6PZVJOD24LJUBYQLJXYBXV6JW6ZZCJYLTHQ6KVMZZISC63SUBA") }
    let(:memo_required_kp) { Stellar::KeyPair.from_seed("SAUZR3L5N43GQQZWO5HDSQJ76J65H5BUCNDRQB4DMA72ZJUXNUXVVTJY") }

    it("doesn't raise an error when a transaction has a memo", {
      vcr: {record: :once, match_requests_on: [:method]}
    }) do
      seq_num = client.account_info(kp.address).sequence.to_i + 1
      tx = Stellar::TransactionBuilder.new(
        source_account: kp,
        sequence_number: seq_num,
        memo: Stellar::Memo.new(:memo_text, "test memo")
      ).add_operation(
        Stellar::Operation.payment({
          destination: memo_required_kp,
          amount: [Stellar::Asset.native, 100]
        })
      ).set_timeout(600).build
      envelope = tx.to_envelope(kp)

      client.submit_transaction(tx_envelope: envelope)
    end

    it("raises an error for missing memo", {
      vcr: {record: :once, match_requests_on: [:method]}
    }) do
      seq_num = client.account_info(kp.address).sequence.to_i + 1
      tx = Stellar::TransactionBuilder.new(
        source_account: kp,
        sequence_number: seq_num
      ).add_operation(
        Stellar::Operation.payment({
          destination: memo_required_kp,
          amount: [Stellar::Asset.native, 100]
        })
      ).set_timeout(600).build
      envelope = tx.to_envelope(kp)

      expect {
        client.submit_transaction(tx_envelope: envelope)
      }.to raise_error(
        an_instance_of(
          Stellar::AccountRequiresMemoError
        ).and(
          having_attributes(
            message: "account requires memo",
            account_id: memo_required_kp.muxed_account,
            operation_index: 0
          )
        )
      )
    end

    it("succeeds for a mix of operations, memo included", {
      vcr: {record: :once, match_requests_on: [:method]}
    }) do
      seq_num = client.account_info(kp.address).sequence.to_i + 1
      tx = Stellar::TransactionBuilder.new(
        source_account: kp,
        sequence_number: seq_num,
        memo: Stellar::Memo.new(:memo_text, "test memo")
      ).add_operation(
        Stellar::Operation.payment({
          destination: memo_required_kp,
          amount: [Stellar::Asset.native, 100]
        })
      ).add_operation(
        Stellar::Operation.bump_sequence({bump_to: seq_num + 2})
      ).set_timeout(600).build
      envelope = tx.to_envelope(kp)

      client.submit_transaction(tx_envelope: envelope)
    end

    it("fails for a mix of operations, memo not included", {
      vcr: {record: :once, match_requests_on: [:method]}
    }) do
      seq_num = client.account_info(kp.address).sequence.to_i + 1
      tx = Stellar::TransactionBuilder.new(
        source_account: kp,
        sequence_number: seq_num
      ).add_operation(
        Stellar::Operation.bump_sequence({bump_to: seq_num + 2})
      ).add_operation(
        Stellar::Operation.payment({
          destination: memo_required_kp,
          amount: [Stellar::Asset.native, 100]
        })
      ).set_timeout(600).build
      envelope = tx.to_envelope(kp)

      expect {
        client.submit_transaction(tx_envelope: envelope)
      }.to raise_error(
        an_instance_of(
          Stellar::AccountRequiresMemoError
        ).and(
          having_attributes(
            message: "account requires memo",
            account_id: memo_required_kp.muxed_account,
            operation_index: 1
          )
        )
      )
    end

    it("succeeds for operations that don't require memos", {
      vcr: {record: :once, match_requests_on: [:method]}
    }) do
      seq_num = client.account_info(kp.address).sequence.to_i + 1
      tx = Stellar::TransactionBuilder.new(
        source_account: kp,
        sequence_number: seq_num
      ).add_operation(
        Stellar::Operation.bump_sequence({bump_to: seq_num + 2})
      ).set_timeout(600).build
      envelope = tx.to_envelope(kp)

      client.submit_transaction(tx_envelope: envelope)
    end
  end

  # TODO refactor using contexts and moving tx building out of examples
  describe "#check_memo_required" do
    let(:kp) { Stellar::KeyPair.from_seed("SA27TR6PZVJOD24LJUBYQLJXYBXV6JW6ZZCJYLTHQ6KVMZZISC63SUBA") }
    let(:memo_required_kp) { Stellar::KeyPair.from_seed("SAUZR3L5N43GQQZWO5HDSQJ76J65H5BUCNDRQB4DMA72ZJUXNUXVVTJY") }

    it("raises an error for missing memo", {
      vcr: {record: :once, match_requests_on: [:method]}
    }) do
      seq_num = client.account_info(kp.address).sequence.to_i + 1
      tx = Stellar::TransactionBuilder.new(
        source_account: kp,
        sequence_number: seq_num
      ).add_operation(
        Stellar::Operation.payment({
          destination: memo_required_kp,
          amount: [Stellar::Asset.native, 100]
        })
      ).set_timeout(600).build
      envelope = tx.to_envelope(kp)

      expect {
        client.check_memo_required(envelope)
      }.to raise_error(
        an_instance_of(
          Stellar::AccountRequiresMemoError
        ).and(
          having_attributes(
            message: "account requires memo",
            account_id: memo_required_kp.muxed_account,
            operation_index: 0
          )
        )
      )
    end

    it("raises an error for missing memo on account merge operations", {
      vcr: {record: :once, match_requests_on: [:method]}
    }) do
      seq_num = client.account_info(kp.address).sequence.to_i + 1
      tx = Stellar::TransactionBuilder.new(
        source_account: kp,
        sequence_number: seq_num
      ).add_operation(
        Stellar::Operation.account_merge({
          destination: memo_required_kp
        })
      ).set_timeout(600).build
      envelope = tx.to_envelope(kp)

      expect {
        client.check_memo_required(envelope)
      }.to raise_error(
        an_instance_of(
          Stellar::AccountRequiresMemoError
        ).and(
          having_attributes(
            message: "account requires memo",
            account_id: memo_required_kp.muxed_account,
            operation_index: 0
          )
        )
      )
    end

    it("succeeds with a multi-operation transaction", {
      vcr: {record: :once, match_requests_on: [:method]}
    }) do
      seq_num = client.account_info(kp.address).sequence.to_i + 1
      tx = Stellar::TransactionBuilder.new(
        source_account: kp,
        sequence_number: seq_num,
        memo: Stellar::Memo.new(:memo_text, "test memo")
      ).add_operation(
        Stellar::Operation.payment({
          destination: memo_required_kp,
          amount: [Stellar::Asset.native, 100]
        })
      ).add_operation(
        Stellar::Operation.account_merge({
          destination: memo_required_kp
        })
      ).set_timeout(600).build
      envelope = tx.to_envelope(kp)

      client.check_memo_required(envelope)
    end

    it("doesn't raise an error when a transaction has a memo", {
      vcr: {record: :once, match_requests_on: [:method]}
    }) do
      seq_num = client.account_info(kp.address).sequence.to_i + 1
      tx = Stellar::TransactionBuilder.new(
        source_account: kp,
        sequence_number: seq_num,
        memo: Stellar::Memo.new(:memo_text, "test memo")
      ).add_operation(
        Stellar::Operation.payment({
          destination: memo_required_kp,
          amount: [Stellar::Asset.native, 100]
        })
      ).set_timeout(600).build
      envelope = tx.to_envelope(kp)

      client.check_memo_required(envelope)
    end

    context "when destination is muxed account" do
      it "skips the check" do
      end
    end

    context "when tx is fee bump" do
      let(:inner_tx_source) { Stellar::KeyPair.from_seed("SDV5KT5DLFVUA2OCBXQSKTZ7E7MBLEJ23UH5FDHGWTXFKOCN34GRR2BA") }
      let(:fee_source) { Stellar::KeyPair.from_seed("SDHEM6T54CZ2OB3HM6JMHOXMLUI3GOGSR5VF26EO35I3NDWWZVPPHBGL") }

      it "raises an error for missing memo", vcr: {record: :once, match_requests_on: [:method]} do
        inner_tx_seq_num = client.account_info(inner_tx_source.address).sequence.to_i + 1

        inner_tx = Stellar::TransactionBuilder.new(
          source_account: inner_tx_source,
          sequence_number: inner_tx_seq_num
        ).add_operation(
          Stellar::Operation.payment(
            destination: memo_required_kp,
            amount: [Stellar::Asset.native, 100]
          )
        ).set_timeout(0).build

        fee_bump_seq_num = client.account_info(fee_source.address).sequence.to_i + 1

        fee_bump_tx = Stellar::TransactionBuilder.new(
          source_account: fee_source,
          sequence_number: fee_bump_seq_num
        ).build_fee_bump(inner_txe: inner_tx.to_envelope(inner_tx_source))

        envelope = fee_bump_tx.to_envelope(fee_source)

        expect { client.check_memo_required(envelope) }.to raise_error(
          an_instance_of(Stellar::AccountRequiresMemoError).and(
            having_attributes(
              message: "account requires memo",
              account_id: memo_required_kp.muxed_account,
              operation_index: 0
            )
          )
        )
      end
    end
  end
end
