require "spec_helper"

describe Stellar::Client do

  subject(:client) { Stellar::Client.default_testnet }

  describe "headers" do
    let(:headers) { client.horizon.headers }

    it "has 'Accept'" do
      expect(headers["Accept"]).
        to eq "application/hal+json,application/problem+json,application/json"
    end

    it "has 'X-Client-Name'" do
      expect(headers["X-Client-Name"]).to eq "ruby-stellar-sdk"
    end

    it "has 'X-Client-Version'" do
      expect(headers["X-Client-Version"]).to eq Stellar::VERSION
    end
  end

  describe "#default_testnet" do
    it 'instantiates a client pointing to horizon testnet' do
      client = described_class.default_testnet
      expect(client.horizon._url).to eq(described_class::HORIZON_TESTNET_URL)
    end
  end

  describe "#default" do
    it 'instantiates a client pointing to horizon mainnet' do
      client = described_class.default
      expect(client.horizon._url).to eq(described_class::HORIZON_MAINNET_URL)
    end
  end

  describe "#localhost" do
    it 'instantiates a client pointing to localhost horizon' do
      client = described_class.localhost
      expect(client.horizon._url).to eq(described_class::HORIZON_LOCALHOST_URL)
    end
  end

  describe "#initialize" do
    let(:custom_horizon_url) { 'https://horizon.domain.com' }
    it 'instantiates a client accepting custom options' do
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
      native_asset_balance_info = balances.find do |b|
        b["asset_type"] == "native"
      end
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
        starting_balance: 100,
      )

      destination_info = client.account_info(destination)
      balances = destination_info.balances
      expect(balances).to_not be_empty
      native_asset_balance_info = balances.find do |b|
        b["asset_type"] == "native"
      end
      expect(native_asset_balance_info["balance"].to_f).to eq 100.0
    end
  end

  describe "#account_info" do
    let(:account) { Stellar::Account.from_seed(CONFIG[:source_seed]) }
    let(:client) { Stellar::Client.default_testnet }

    it "returns the current details for the account", vcr: { record: :once, match_requests_on: [:method]} do
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

    it "merges source account into destination", vcr: { record: :once, match_requests_on: [:method]} do
      [source, destination].each do |account|
        account = client.create_account(
          funder: funder,
          account: account,
          starting_balance: 100,
        )
      end

      client.account_merge(
        account: source,
        destination: destination
      )

      destination_info = client.account_info(destination)
      native_asset_balance_info = destination_info.balances.find do |b|
        b["asset_type"] == "native"
      end
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
          starting_balance: 100,
        )

        amount = Stellar::Amount.new(150)

        client.send_payment(
          from: source,
          to: destination,
          amount: amount,
        )

        destination_info = client.account_info(destination)
        balances = destination_info.balances
        expect(balances).to_not be_empty
        native_asset_balance_info = balances.find do |b|
          b["asset_type"] == "native"
        end
        expect(native_asset_balance_info["balance"].to_f).to eq 250.0
      end
    end

    context "alphanum4 asset" do
      let(:issuer) { Stellar::Account.from_seed(CONFIG[:source_seed]) }
      let(:destination) { Stellar::Account.random }

      it("sends a alphanum4 asset to the destination", {
        vcr: {record: :once, match_requests_on: [:method]},
      }) do
        client.create_account(
          funder: issuer,
          account: destination,
          starting_balance: 2,
        )

        client.change_trust(
          asset: [:alphanum4, "BTC", issuer.keypair],
          source: destination,
        )

        asset = Stellar::Asset.alphanum4("BTC", source.keypair)
        amount = Stellar::Amount.new(150, asset)
        client.send_payment(
          from: source,
          to: destination,
          amount: amount,
        )

        destination_info = client.account_info(destination)
        btc_balance = destination_info.balances.find do |b|
          b["asset_code"] == "BTC"
        end["balance"].to_f

        expect(btc_balance).to eq 150.0
      end
    end

    context "alphanum12 asset" do
      let(:issuer) { Stellar::Account.from_seed(CONFIG[:source_seed]) }
      let(:destination) { Stellar::Account.random }

      it("sends a alphanum12 asset to the destination", {
        vcr: {record: :once, match_requests_on: [:method]},
      }) do
        client.create_account(
          funder: issuer,
          account: destination,
          starting_balance: 2,
        )

        client.change_trust(
          asset: [:alphanum12, "LONGNAME", issuer.keypair],
          source: destination,
        )

        asset = Stellar::Asset.alphanum12("LONGNAME", source.keypair)
        amount = Stellar::Amount.new(150, asset)

        client.send_payment(
          from: source,
          to: destination,
          amount: amount,
        )

        destination_info = client.account_info(destination)
        btc_balance = destination_info.balances.find do |b|
          b["asset_code"] == "LONGNAME"
        end["balance"].to_f

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
          starting_balance: 100,
        )

        amount = Stellar::Amount.new(150)

        client.send_payment(
          from: source,
          to: destination,
          amount: amount,
          memo: "DESUKA",
        )

        last_tx = client.account_info(destination).
          transactions(order: "desc")._get._embedded.records.first
        expect(last_tx.memo).to eq "DESUKA"
      end
    end

    context "using a payment channel" do
      let(:transaction_source) { Stellar::Account.from_seed(CONFIG[:channel_seed]) }
      let(:destination) { Stellar::Account.random }

      it("sends a payment account through a channel account", {
        vcr: {record: :once, match_requests_on: [:method]},
      }) do
        client.create_account(
          funder: source,
          account: destination,
          starting_balance: 1,
        )

        tx = client.send_payment(
          from: source,
          to: destination,
          amount: Stellar::Amount.new(0.55),
          transaction_source: transaction_source,
        )

        tx_hash = tx._attributes["hash"]

        tx = client.horizon.transaction(hash: tx_hash)
        expect(tx.source_account).to eq transaction_source.address

        operation = tx.operations.records.first
        expect(operation.from).to eq source.address

        destination_info = client.account_info(destination)
        balances = destination_info.balances
        expect(balances).to_not be_empty
        native_asset_balance_info = balances.find do |b|
          b["asset_type"] == "native"
        end
        expect(native_asset_balance_info["balance"].to_f).to eq 1.55
      end

      it("sends a payment when the channel is the same as `from`", {
        vcr: {record: :once, match_requests_on: [:method]},
      }) do
        client.create_account(
          funder: source,
          account: destination,
          starting_balance: 1,
        )

        tx = client.send_payment(
          from: source,
          to: destination,
          amount: Stellar::Amount.new(0.55),
          transaction_source: source,
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
    let(:cursor) { '348403452088320' }

    context "account transactions" do
      let(:account) { Stellar::Account.from_seed(CONFIG[:source_seed]) }

      it "returns a list of transaction for an account", vcr: {record: :once, match_requests_on: [:method]} do
        response = client.transactions(account: account)
        expect(response).to be_a(Stellar::TransactionPage)
      end

      it "accepts a cursor to return less data", vcr: {record: :once, match_requests_on: [:method]} do
        response = client.transactions(account: account,
                                       cursor: cursor)
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
        vcr: {record: :once, match_requests_on: [:method]},
      }) do
        client.create_account(
          funder: issuer,
          account: truster,
          starting_balance: 2,
        )

        # Create trustline
        client.change_trust(
          asset: [:alphanum4, "BTC", issuer.keypair],
          source: truster,
        )

        truster_info = client.account_info(truster)
        btc_balance = truster_info.balances.find do |b|
          b["asset_code"] == "BTC" && b["asset_issuer"] == issuer.address
        end

        expect(btc_balance).to_not be_nil

        # Update trustline
        client.change_trust(
          asset: [:alphanum4, "BTC", issuer.keypair],
          source: truster,
          limit: 100,
        )

        truster_info = client.account_info(truster)
        btc_balance = truster_info.balances.find do |b|
          b["asset_code"] == "BTC" && b["asset_issuer"] == issuer.address
        end

        expect(btc_balance["limit"].to_f).to eq 100

        # Delete trustline
        client.change_trust(
          asset: [:alphanum4, "BTC", issuer.keypair],
          source: truster,
          limit: 0,
        )

        truster_info = client.account_info(truster)
        btc_balance = truster_info.balances.find do |b|
          b["asset_code"] == "BTC" && b["asset_issuer"] == issuer.address
        end

        expect(btc_balance).to be_nil
      end
    end
  end

  describe "SEP0010 helpers" do
    let(:server) { Stellar::KeyPair.random }
    let(:user) { Stellar::KeyPair.random }
    let(:anchor) { "SDF" }
    let(:timeout) { 600 }
    let(:envelope) { Stellar::TransactionEnvelope.from_xdr(subject, "base64") }
    let(:transaction) { envelope.tx }  

    subject do
      client.build_challenge_tx(server: server, client: user, anchor_name: anchor, timeout: timeout) 
    end
    
    describe "#build_challenge_tx" do      
      it "generates a valid SEP10 challenge" do
        expect(transaction.seq_num).to eql(0)
        expect(transaction.operations.size).to eql(1);
        expect(transaction.source_account).to eql(server.public_key);

        time_bounds = transaction.time_bounds
        expect(time_bounds.max_time - time_bounds.min_time).to eql(600)
        operation = transaction.operations.first

        expect(operation.body.arm).to eql(:manage_data_op)
        expect(operation.body.value.data_name).to eql("SDF auth")
        expect(operation.source_account).to eql(user.public_key)
        data_value = operation.body.value.data_value
        expect(data_value.bytes.size).to eql(64)
        expect(data_value.unpack("m")[0].size).to eql(48)
      end

      describe "defaults" do
        subject do
          client.build_challenge_tx(server: server, client: user, anchor_name: anchor) 
        end
        
        it "has a default timeout of 300 seconds (5 minutes)" do
          time_bounds = transaction.time_bounds
          expect(time_bounds.max_time - time_bounds.min_time).to eql(300)
        end
      end
    end

    describe "#read_challenge_tx" do
      subject do
        challenge = super()
        envelope = Stellar::TransactionEnvelope.from_xdr(challenge, 'base64')
        envelope.tx.to_envelope(server, user).to_xdr(:base64)
      end
      
      it "returns the envelope and client public key if the transaction is valid" do
        expect(client.read_challenge_tx(challenge: subject, server: server)).to eql([envelope, user.public_key])
      end

      it "throws an error if transaction sequence number is different to zero"  do
        envelope.tx.seq_num = 1

        expect { 
         client.read_challenge_tx(challenge: envelope.to_xdr(:base64), server: server)
        }.to raise_error(Stellar::InvalidSep10ChallengeError, /The transaction sequence number should be zero/)
      end      

      it "throws an error if transaction source account is different to server account id"  do
        expect {
          client.read_challenge_tx(challenge: envelope.to_xdr(:base64), server: Stellar::KeyPair.random)
        }.to raise_error(Stellar::InvalidSep10ChallengeError, /The transaction source account is not equal to the server's account/)
      end

      it "throws an error if transaction doestn\'t contain any operation" do
        envelope.tx.operations = []

        expect { 
         client.read_challenge_tx(challenge: envelope.to_xdr(:base64), server: server)
        }.to raise_error(Stellar::InvalidSep10ChallengeError, /The transaction should contain only one operation/)
       end

      it "throws an error if operation does not contain the source account" do
        op = envelope.tx.operations[0]
        op.source_account = nil

        expect { 
         client.read_challenge_tx(challenge: envelope.to_xdr(:base64), server: server)
        }.to raise_error(Stellar::InvalidSep10ChallengeError, /The transaction's operation should contain a source account/)
       end
       
      it "throws an error if operation is not manage data"  do
        envelope.tx.operations = [ 
          Stellar::Operation.payment(
            destination: Stellar::KeyPair.random, 
            amount: [:native, 20],
            source_account: Stellar::KeyPair.random
          )
        ]

        expect { 
         client.read_challenge_tx(challenge: envelope.to_xdr(:base64), server: server)
        }.to raise_error(Stellar::InvalidSep10ChallengeError, /The transaction's operation should be manageData/)
       end

      it "throws an error if operation value is not a 64 bytes base64 string" do
        transaction.operations[0].body.value.data_value = SecureRandom.random_bytes(64)
        expect { 
          client.read_challenge_tx(challenge: envelope.to_xdr(:base64), server: server)          
        }.to raise_error(
          Stellar::InvalidSep10ChallengeError,
          /The transaction's operation value should be a 64 bytes base64 random string/
        )
      end

      it "throws an error if transaction is not signed by the server" do
        envelope.signatures = envelope.signatures.slice(1, 2)
        
        expect { 
          client.read_challenge_tx(challenge: envelope.to_xdr(:base64), server: server)          
        }.to raise_error(
          Stellar::InvalidSep10ChallengeError,
          /The transaction is not signed by the server/
        )
      end

      # TODO: move this test to describe "#verify_challenge_transaction_signed_by_client_master_key"
      xit "throws an error if transaction is not signed by the client" do
        envelope.signatures = envelope.signatures.slice(0,1)
        expect { 
          client.read_challenge_tx(challenge: envelope.to_xdr(:base64), server: server)          
        }.to raise_error(
          Stellar::InvalidSep10ChallengeError,
          /The transaction is not signed by the client/
        )
      end

      it "throws an error if transaction does not contain valid timeBounds" do
        envelope.tx.time_bounds = nil
        challenge = envelope.tx.to_envelope(server, user).to_xdr(:base64)

        expect { 
          client.read_challenge_tx(challenge: challenge, server: server)          
        }.to raise_error(
          Stellar::InvalidSep10ChallengeError,
          /The transaction has expired/
        )

        envelope.tx.time_bounds = Stellar::TimeBounds.new(min_time: 0, max_time: 5)
        challenge = envelope.tx.to_envelope(server, user).to_xdr(:base64)

        expect { 
          client.read_challenge_tx(challenge: challenge, server: server)          
        }.to raise_error(
          Stellar::InvalidSep10ChallengeError,
          /The transaction has expired/
        )

        now = Time.now.to_i
        envelope.tx.time_bounds = Stellar::TimeBounds.new(
          min_time: now + 100, 
          max_time: now + 500
        )
        challenge = envelope.tx.to_envelope(server, user).to_xdr(:base64)

        expect { 
          client.read_challenge_tx(challenge: challenge, server: server)          
        }.to raise_error(
          Stellar::InvalidSep10ChallengeError,
          /The transaction has expired/
        )
      end
    end
  end

  describe "#verify_tx_signed_by" do
    let(:keypair) { Stellar::KeyPair.random }
    let(:envelope) do
      Stellar::Transaction.bump_sequence(account: keypair, bump_to: 1000, sequence: 0).to_envelope(keypair)
    end
    
    it "returns true if transaction envelope is signed by keypair" do
      result = client.verify_tx_signed_by(transaction_envelope: envelope, keypair: keypair)
      expect(result).to eql(true)
    end
    
    it "returns false if transaction envelope is not signed by keypair" do
      result = client.verify_tx_signed_by(
        transaction_envelope: envelope, 
        keypair: Stellar::KeyPair.random
      )
      expect(result).to eql(false)
    end
  end
end