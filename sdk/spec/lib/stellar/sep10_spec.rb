RSpec.describe Stellar::SEP10 do
  let(:server) { KeyPair() }
  let(:user) { KeyPair() }
  let(:domain) { "testnet.stellar.org" }
  let(:nonce) { SecureRandom.base64(48) }

  let(:challenge) { described_class.build_challenge_tx(server: server, client: user, domain: domain) }
  let(:envelope) { Stellar::TransactionEnvelope.from_xdr(challenge, :base64) }
  let(:transaction) { envelope.tx }

  let(:signers) { [server, user] }
  let(:response) { transaction.to_envelope(*signers) }
  let(:response_xdr) { response.to_xdr(:base64) }

  describe ".build_challenge_tx" do
    let(:attrs) { {server: server, client: user, domain: domain} }

    subject(:challenge) do
      xdr = described_class.build_challenge_tx(**attrs)
      Stellar::TransactionEnvelope.from_xdr(xdr, :base64).tx
    end

    it "generates a valid SEP10 challenge" do
      expect(challenge.seq_num).to eql(0)
      expect(challenge.operations.size).to eql(1)
      expect(challenge.source_account).to eql(server.muxed_account)

      time_bounds = challenge.time_bounds
      expect(time_bounds.max_time - time_bounds.min_time).to eql(300)

      operation = challenge.operations.first
      expect(operation.source_account).to eql(user.muxed_account)

      body = operation.body
      expect(body.arm).to eql(:manage_data_op)
      expect(body.data_name).to eql("testnet.stellar.org auth")
      expect(body.data_value.bytes.size).to eql(64)
      expect(body.data_value.unpack1("m").size).to eql(48)
    end

    it "allows to customize challenge timeout" do
      attrs[:timeout] = 600

      time_bounds = challenge.time_bounds
      expect(time_bounds.max_time - time_bounds.min_time).to eql(600)
    end
  end

  describe "#read_challenge_tx" do
    let(:attrs) { {challenge_xdr: response_xdr, server: server} }

    let(:extra_operation) {
      Stellar::Operation.manage_data(source_account: server, name: "extra", value: "operation")
    }

    let(:invalid_operation) {
      Stellar::Operation.payment(source_account: server, destination: KeyPair(), amount: [:native, 20])
    }

    subject(:read_challenge) {
      described_class.read_challenge_tx(**attrs)
    }

    it "returns the envelope and client public key if the transaction is valid" do
      expect(read_challenge).to eq([response, user.address])
    end

    it "returns the envelope even if transaction signed by server but not client" do
      signers.replace([server])

      expect(read_challenge).to eq([response, user.address])
    end

    it "allows extra manage data operations with server as source" do
      transaction.operations << extra_operation

      expect(read_challenge).to eq([response, user.address])
    end

    it "throws an error if transaction sequence number is different to zero" do
      transaction.seq_num = 1

      expect { read_challenge }.to raise_invalid("sequence number should be zero")
    end

    it "throws an error if transaction source account is different to server account id" do
      attrs[:server] = KeyPair()
      expect { read_challenge }.to raise_invalid("source account is not equal to the server's account")
    end

    it "throws an error if transaction doesn't contain any operation" do
      transaction.operations.clear

      expect { read_challenge }.to raise_invalid("should contain at least one operation")
    end

    it "throws an error if operation does not contain the source account" do
      transaction.operations.first.source_account = nil

      expect { read_challenge }.to raise_invalid("operation should contain a source account")
    end

    it "throws an error if operation is not manage data" do
      transaction.operations.replace([invalid_operation])

      expect { read_challenge }.to raise_invalid("first operation should be manageData")
    end

    it "throws an error if operation value is not a 64 bytes base64 string" do
      transaction.operations.first.body.value.data_value = SecureRandom.random_bytes(64)
      expect { read_challenge }.to raise_invalid("value should be a 64 bytes base64 random string")
    end

    it "throws an error if transaction contains operations except manage data " do
      transaction.operations << invalid_operation

      expect { read_challenge }.to raise_invalid("has operations that are not of type 'manageData'")
    end

    it "throws an error if transaction contains extra operation not from the server" do
      extra_operation.source_account = KeyPair().muxed_account
      transaction.operations << extra_operation

      expect { read_challenge }.to raise_invalid("has operations that are unrecognized")
    end

    it "throws an error if transaction is not signed by the server" do
      signers.replace([user])

      expect { read_challenge }.to raise_invalid("is not signed by the server")
    end

    it "throws an error if transaction does not contain timeBounds" do
      transaction.time_bounds = nil

      expect { read_challenge }.to raise_invalid("has expired")
    end

    it "throws an error if challenge is expired" do
      transaction.time_bounds = Stellar::TimeBounds.new(min_time: 0, max_time: 5)

      expect { read_challenge }.to raise_invalid("has expired")
    end

    it "throws an error if challenge is in the future" do
      now = Time.now.to_i
      transaction.time_bounds = Stellar::TimeBounds.new(min_time: now + 100, max_time: now + 500)

      expect { read_challenge }.to raise_invalid("has expired")
    end
  end

  describe "#verify_challenge_tx_threshold" do
    let(:cosigner_a) { KeyPair() }
    let(:cosigner_b) { KeyPair() }
    let(:cosigner_c) { KeyPair() }
    let(:cosigners) { Hash(user.address => 1, cosigner_a.address => 2, cosigner_b.address => 4) }
    let(:signers) { [server, user, cosigner_a, cosigner_b] }
    let(:args) { {} }

    subject(:verify_threshold) do
      described_class.verify_challenge_tx_threshold(
        server: server,
        challenge_xdr: response_xdr,
        signers: cosigners,
        threshold: 7,
        **args
      )
    end

    it "verifies proper challenge and threshold" do
      expect(verify_threshold).to eq cosigners.keys.to_set
    end

    it "verifies when not all cosigners have signed but threshold is met" do
      signers.delete(cosigner_b)
      args[:threshold] = 3

      expect(verify_threshold).to contain_exactly(user.address, cosigner_a.address)
    end

    it "ignores non-G address" do
      signers.replace([server, user])
      cosigners.replace(
        user.address => 1,
        "TAQCSRX2RIDJNHFIFHWD63X7D7D6TRT5Y2S6E3TEMXTG5W3OECHZ2OG4" => 1, # pre_auth_tx
        "XDRPF6NZRR7EEVO7ESIWUDXHAOMM2QSKIQQBJK6I2FB7YKDZES5UCLWD" => 1 # hash_x
      )
      args[:threshold] = 1

      expect(verify_threshold).to contain_exactly(user.address)
    end

    it "raises if transaction not signed by server" do
      signers.delete(server)

      expect { verify_threshold }.to raise_invalid("is not signed by the server")
    end

    it "raises on signatures not from cosigners" do
      signers << cosigner_c
      args[:threshold] = 2

      expect { verify_threshold }.to raise_invalid("has unrecognized signatures")
    end

    it "raises error when signers don't meet threshold" do
      args[:threshold] = 8

      expect { verify_threshold }.to raise_invalid("signers with weight 7 do not meet threshold 8")
    end

    it "raises no signers error" do
      cosigners.replace({})
      expect { verify_threshold }.to raise_invalid("no signers provided")
    end

    it "raises an error for no signatures" do
      signers.replace([])
      expect { verify_threshold }.to raise_invalid("is not signed by the server")
    end

    it "raises an error for duplicate signatures" do
      signers.replace [server, user, user]
      expect { verify_threshold }.to raise_invalid("has unrecognized signatures")
    end
  end

  describe "#verify_challenge_tx_signers" do
    let(:cosigner_a) { KeyPair() }
    let(:cosigner_b) { KeyPair() }
    let(:cosigner_c) { KeyPair() }
    let(:cosigners) { [user.address, cosigner_a.address, cosigner_b.address] }
    let(:signers) { [server, user, cosigner_a, cosigner_b] }

    subject(:verify_signers) do
      described_class.verify_challenge_tx_signers(
        server: server,
        challenge_xdr: response_xdr,
        signers: cosigners
      )
    end

    it "returns expected signatures" do
      expect(verify_signers).to contain_exactly(user.address, cosigner_a.address, cosigner_b.address)
    end

    it "succeeds even when the server is included in the passed signers" do
      signers.replace [server, user]
      cosigners.replace [server.address, user.address]

      expect(verify_signers).to contain_exactly(user.address)
    end

    it "succeeds with extra signers passed" do
      cosigners << cosigner_c.address
      expect(verify_signers).to contain_exactly(user.address, cosigner_a.address, cosigner_b.address)
    end

    it "does not pass back duplicate signers" do
      signers.replace [server, user]
      cosigners.replace [user.address, user.address, user.address]
      expect(verify_signers).to contain_exactly(user.address)
    end

    it "ignores non-G address" do
      cosigners << "TAQCSRX2RIDJNHFIFHWD63X7D7D6TRT5Y2S6E3TEMXTG5W3OECHZ2OG4" # pre-auth tx
      cosigners << "XDRPF6NZRR7EEVO7ESIWUDXHAOMM2QSKIQQBJK6I2FB7YKDZES5UCLWD" # hash(x)

      expect(verify_signers).to contain_exactly(user.address, cosigner_a.address, cosigner_b.address)
    end

    it "raises no signers error" do
      cosigners.clear
      expect { verify_signers }.to raise_invalid("no signers provided")
    end

    it "raises transaction not signed by server" do
      signers.delete(server)

      expect { verify_signers }.to raise_invalid("is not signed by the server")
    end

    it "raises no client signers found" do
      cosigners.replace [KeyPair().address, KeyPair().address, KeyPair().address]
      expect { verify_signers }.to raise_invalid("not signed by any client signer")
    end

    it "raises unrecognized signatures" do
      signers << KeyPair()

      expect { verify_signers }.to raise_invalid("has unrecognized signatures")
    end

    it "raises an error when transaction only has server signature" do
      cosigners.replace [server.address]

      expect { verify_signers }.to raise_invalid("at least one regular signer must be provided")
    end

    it "raises an error for duplicate signatures" do
      signers << user
      expect { verify_signers }.to raise_invalid("has unrecognized signatures")
    end

    it "raises an error for no signatures" do
      signers.clear

      expect { verify_signers }.to raise_invalid("is not signed by the server")
    end
  end

  describe "#verify_tx_signatures" do
    let(:cosigner_a) { KeyPair() }
    let(:cosigner_b) { KeyPair() }
    let(:cosigner_c) { KeyPair() }
    let(:cosigners) { [user.address, cosigner_a.address, cosigner_b.address] }
    let(:signers) { [server, user, cosigner_a, cosigner_b] }

    subject(:verify_signatures) do
      described_class.verify_tx_signatures(tx_envelope: response, signers: signers)
    end

    it "returns expected signatures" do
      expect(verify_signatures).to contain_exactly(server.address, user.address, cosigner_a.address, cosigner_b.address)
    end

    it "removes duplicate signers" do
      signers.replace [server, user, user]
      cosigners.replace [user.address, user.address, KeyPair().address]
      expect(verify_signatures).to contain_exactly(server.address, user.address)
    end

    it "raises no signature error" do
      signers.clear
      cosigners.replace [user.address]
      expect { verify_signatures }.to raise_invalid("has no signatures")
    end
  end

  describe "#verify_tx_signed_by" do
    let(:keypair) { KeyPair() }
    let(:envelope) do
      Stellar::TransactionBuilder.bump_sequence(
        source_account: keypair,
        bump_to: 1000,
        sequence_number: 0
      ).to_envelope(keypair)
    end
    let(:overrides) { {} }

    subject(:verify_signed_by) do
      described_class.verify_tx_signed_by(tx_envelope: envelope, keypair: keypair, **overrides)
    end

    it "returns true if transaction envelope is signed by keypair" do
      expect(verify_signed_by).to be_truthy
    end

    it "returns false if transaction envelope is not signed by keypair" do
      overrides[:keypair] = KeyPair()
      expect(verify_signed_by).to be_falsey
    end
  end

  def raise_invalid(cause)
    raise_error(Stellar::InvalidSep10ChallengeError, Regexp.compile(cause))
  end
end
