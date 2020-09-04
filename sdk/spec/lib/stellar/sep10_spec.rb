RSpec.describe Stellar::SEP10 do
  subject(:sep10) { Stellar::SEP10 }

  let(:server) { Stellar::KeyPair.random }
  let(:user) { Stellar::KeyPair.random }
  let(:anchor) { "SDF" }
  let(:timeout) { 600 }
  let(:envelope) { Stellar::TransactionEnvelope.from_xdr(subject, "base64") }
  let(:transaction) { envelope.tx }

  subject do
    sep10.build_challenge_tx(server: server, client: user, anchor_name: anchor, timeout: timeout)
  end

  describe "#build_challenge_tx" do
    it "generates a valid SEP10 challenge" do
      expect(transaction.seq_num).to eql(0)
      expect(transaction.operations.size).to eql(1)
      expect(transaction.source_account).to eql(server.muxed_account)

      time_bounds = transaction.time_bounds
      expect(time_bounds.max_time - time_bounds.min_time).to eql(600)
      operation = transaction.operations.first

      expect(operation.body.arm).to eql(:manage_data_op)
      expect(operation.body.value.data_name).to eql("SDF auth")
      expect(operation.source_account).to eql(user.muxed_account)
      data_value = operation.body.value.data_value
      expect(data_value.bytes.size).to eql(64)
      expect(data_value.unpack1("m").size).to eql(48)
    end

    describe "defaults" do
      subject do
        sep10.build_challenge_tx(server: server, client: user, anchor_name: anchor)
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
      envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")
      envelope.tx.to_envelope(server, user).to_xdr(:base64)
    end

    it "returns the envelope and client public key if the transaction is valid" do
      expect(sep10.read_challenge_tx(challenge_xdr: subject, server: server)).to eql([envelope, user.address])
    end

    it "returns the envelope even if transaction signed by server but not client" do
      envelope = Stellar::TransactionEnvelope.from_xdr(subject, "base64")
      expected_envelope = envelope.tx.to_envelope(server)
      expect(
        sep10.read_challenge_tx(challenge_xdr: expected_envelope.to_xdr(:base64), server: server)
      ).to eql(
        [expected_envelope, user.address]
      )
    end

    it "throws an error if there are too many operations on the transaction" do
      envelope = Stellar::TransactionEnvelope.from_xdr(subject, "base64")
      envelope.tx.operations += [Stellar::Operation.bump_sequence({bump_to: 1})]
      bad_challege = envelope.tx.to_envelope(server, user).to_xdr(:base64)
      expect {
        sep10.read_challenge_tx(challenge_xdr: bad_challege, server: server)
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /The transaction should contain only one operation/
      )
    end

    it "throws an error if transaction sequence number is different to zero" do
      envelope.tx.seq_num = 1

      expect {
        sep10.read_challenge_tx(challenge_xdr: envelope.to_xdr(:base64), server: server)
      }.to raise_error(Stellar::InvalidSep10ChallengeError, /The transaction sequence number should be zero/)
    end

    it "throws an error if transaction source account is different to server account id" do
      expect {
        sep10.read_challenge_tx(challenge_xdr: envelope.to_xdr(:base64), server: Stellar::KeyPair.random)
      }.to raise_error(Stellar::InvalidSep10ChallengeError, /The transaction source account is not equal to the server's account/)
    end

    it "throws an error if transaction doesn't contain any operation" do
      envelope.tx.operations = []

      expect {
        sep10.read_challenge_tx(challenge_xdr: envelope.to_xdr(:base64), server: server)
      }.to raise_error(Stellar::InvalidSep10ChallengeError, /The transaction should contain only one operation/)
    end

    it "throws an error if operation does not contain the source account" do
      op = envelope.tx.operations[0]
      op.source_account = nil

      expect {
        sep10.read_challenge_tx(challenge_xdr: envelope.to_xdr(:base64), server: server)
      }.to raise_error(Stellar::InvalidSep10ChallengeError, /The transaction's operation should contain a source account/)
    end

    it "throws an error if operation is not manage data" do
      envelope.tx.operations = [
        Stellar::Operation.payment(
          destination: Stellar::KeyPair.random,
          amount: [:native, 20],
          source_account: Stellar::KeyPair.random
        )
      ]

      expect {
        sep10.read_challenge_tx(challenge_xdr: envelope.to_xdr(:base64), server: server)
      }.to raise_error(Stellar::InvalidSep10ChallengeError, /The transaction's operation should be manageData/)
    end

    it "throws an error if operation value is not a 64 bytes base64 string" do
      transaction.operations[0].body.value.data_value = SecureRandom.random_bytes(64)
      expect {
        sep10.read_challenge_tx(challenge_xdr: envelope.to_xdr(:base64), server: server)
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /The transaction's operation value should be a 64 bytes base64 random string/
      )
    end

    it "throws an error if transaction is not signed by the server" do
      envelope.signatures = envelope.signatures.slice(1, 2)

      expect {
        sep10.read_challenge_tx(challenge_xdr: envelope.to_xdr(:base64), server: server)
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /The transaction is not signed by the server/
      )
    end

    it "throws an error if transaction does not contain valid timeBounds" do
      envelope.tx.time_bounds = nil
      challenge = envelope.tx.to_envelope(server, user).to_xdr(:base64)

      expect {
        sep10.read_challenge_tx(challenge_xdr: challenge, server: server)
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /The transaction has expired/
      )

      envelope.tx.time_bounds = Stellar::TimeBounds.new(min_time: 0, max_time: 5)
      challenge = envelope.tx.to_envelope(server, user).to_xdr(:base64)

      expect {
        sep10.read_challenge_tx(challenge_xdr: challenge, server: server)
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
        sep10.read_challenge_tx(challenge_xdr: challenge, server: server)
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /The transaction has expired/
      )
    end
  end

  describe "#verify_challenge_tx_threshold" do
    it "raises transaction not signed by server" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp_a,
        anchor_name: anchor_name,
        timeout: timeout
      )

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")
      challenge_envelope.signatures = [client_kp_a, client_kp_b, client_kp_c].map { |kp|
        challenge_envelope.tx.sign_decorated(kp)
      }

      signers = Set[
        {"key" => client_kp_a.address, :weight => 1},
        {"key" => client_kp_b.address, :weight => 1},
        {"key" => client_kp_c.address, :weight => 1}
      ]

      expect {
        sep10.verify_challenge_tx_threshold(
          challenge_xdr: challenge_envelope.to_xdr(:base64),
          server: server_kp,
          signers: signers,
          threshold: 3
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /The transaction is not signed by the server/
      )
    end

    it "succeeds with extra signers passed" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp_a,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures += [
        challenge_envelope.tx.sign_decorated(client_kp_a),
        challenge_envelope.tx.sign_decorated(client_kp_b)
      ]
      challenge = challenge_envelope.to_xdr(:base64)

      expect(
        sep10.verify_challenge_tx_threshold(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[
            {"key" => client_kp_a.address, "weight" => 1},
            {"key" => client_kp_b.address, "weight" => 1},
            {"key" => client_kp_c.address, "weight" => 1}
          ],
          threshold: 2
        )
      ).to eql(
        Set[
          {"key" => client_kp_a.address, "weight" => 1},
          {"key" => client_kp_b.address, "weight" => 1}
        ]
      )
    end

    it "rasies an error for unrecognizied signatures" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp_a,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures += [
        challenge_envelope.tx.sign_decorated(client_kp_a),
        challenge_envelope.tx.sign_decorated(client_kp_b),
        challenge_envelope.tx.sign_decorated(client_kp_c)
      ]
      challenge = challenge_envelope.to_xdr(:base64)

      expect {
        sep10.verify_challenge_tx_threshold(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[
            {"key" => client_kp_a.address, "weight" => 1},
            {"key" => client_kp_b.address, "weight" => 1},
          ],
          threshold: 2
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /Transaction has unrecognized signatures./
      )
    end

    it "verifies proper challenge and threshold" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp_a,
        anchor_name: anchor_name,
        timeout: timeout
      )

      transaction = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")
      transaction.signatures += [
        client_kp_a, client_kp_b, client_kp_c
      ].map { |kp| transaction.tx.sign_decorated(kp) }
      challenge_tx = transaction.to_xdr(:base64)

      signers = Set[
        {"key" => client_kp_a.address, "weight" => 1},
        {"key" => client_kp_b.address, "weight" => 2},
        {"key" => client_kp_c.address, "weight" => 4},
      ]

      signers_found = sep10.verify_challenge_tx_threshold(
        challenge_xdr: challenge_tx,
        server: server_kp,
        threshold: 7,
        signers: signers
      )
      expect(signers_found).to eql(signers)
    end

    it "raises error when signers don't meet threshold" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp_a,
        anchor_name: anchor_name,
        timeout: timeout
      )

      transaction = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")
      transaction.signatures.push(transaction.tx.sign_decorated(client_kp_a))
      challenge_tx = transaction.to_xdr(:base64)

      signers = Set[
        {"key" => client_kp_a.address, "weight" => 1},
        {"key" => client_kp_b.address, "weight" => 2},
        {"key" => client_kp_c.address, "weight" => 4},
      ]

      expect {
        sep10.verify_challenge_tx_threshold(
          challenge_xdr: challenge_tx,
          server: server_kp,
          threshold: 7,
          signers: signers
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        "signers with weight %d do not meet threshold %d." % [1, 7]
      )
    end

    it "ignores non-G address" do
      preauth_tx_hash = "TAQCSRX2RIDJNHFIFHWD63X7D7D6TRT5Y2S6E3TEMXTG5W3OECHZ2OG4"
      x_hash = "XDRPF6NZRR7EEVO7ESIWUDXHAOMM2QSKIQQBJK6I2FB7YKDZES5UCLWD"
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures += [challenge_envelope.tx.sign_decorated(client_kp)]
      challenge = challenge_envelope.to_xdr(:base64)

      expect(
        sep10.verify_challenge_tx_threshold(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[
            {"key" => client_kp.address, "weight" => 1},
            {"key" => preauth_tx_hash, "weight" => 1},
            {"key" => x_hash, "weight" => 1}
          ],
          threshold: 1
        )
      ).to eql(
        Set[
          {"key" => client_kp.address, "weight" => 1}
        ]
      )
    end

    it "raises no signers error" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp_a,
        anchor_name: anchor_name,
        timeout: timeout
      )

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")
      challenge_envelope.signatures += [
        client_kp_a, client_kp_b, client_kp_c
      ].map { |kp| challenge_envelope.tx.sign_decorated(kp) }

      expect {
        sep10.verify_challenge_tx_threshold(
          challenge_xdr: challenge_envelope.to_xdr(:base64),
          server: server_kp,
          signers: Set.new,
          threshold: 2
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /No signers provided./
      )
    end

    it "raises an error for no signatures" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures.clear
      challenge = challenge_envelope.to_xdr(:base64)

      expect {
        sep10.verify_challenge_tx_threshold(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[
            {"key" => client_kp.address, "weight" => 1}
          ],
          threshold: 2
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /The transaction is not signed by the server/
      )
    end

    it "does not pass back duplicate signers or double-count weights" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures += [challenge_envelope.tx.sign_decorated(client_kp)]
      challenge = challenge_envelope.to_xdr(:base64)

      expect(
        sep10.verify_challenge_tx_threshold(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[
            {"key" => client_kp.address, "weight" => 1},
            {"key" => client_kp.address, "weight" => 2}
          ],
          threshold: 1
        )
      ).to eql(
        Set[{"key" => client_kp.address, "weight" => 1}]
      )

      expect {
        sep10.verify_challenge_tx_threshold(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[
            {"key" => client_kp.address, "weight" => 1},
            {"key" => client_kp.address, "weight" => 2}
          ],
          threshold: 3
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /signers with weight 1 do not meet threshold 3./
      )
    end

    it "raises an error for duplicate signatures" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures += [
        challenge_envelope.tx.sign_decorated(client_kp),
        challenge_envelope.tx.sign_decorated(client_kp)
      ]
      challenge = challenge_envelope.to_xdr(:base64)

      expect {
        sep10.verify_challenge_tx_threshold(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[{"key" => client_kp.address, "weight" => 1}],
          threshold: 1
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /Transaction has unrecognized signatures./
      )
    end

    it "raises an error for duplicate signatures and signers" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures += [
        challenge_envelope.tx.sign_decorated(client_kp),
        challenge_envelope.tx.sign_decorated(client_kp)
      ]
      challenge = challenge_envelope.to_xdr(:base64)

      expect {
        sep10.verify_challenge_tx_threshold(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[
            {"key" => client_kp.address, "weight" => 1},
            {"key" => client_kp.address, "weight" => 2}
          ],
          threshold: 1
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /Transaction has unrecognized signatures./
      )
    end
  end

  describe "#verify_challenge_tx" do
    it "verifies proper challenge transaction" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp,
        anchor_name: anchor_name,
        timeout: timeout
      )

      envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")
      envelope.signatures.push(envelope.tx.sign_decorated(client_kp))
      challenge_tx = envelope.to_xdr(:base64)

      sep10.verify_challenge_tx(
        challenge_xdr: challenge_tx,
        server: server_kp
      )
    end

    it "raises not signed by client" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp,
        anchor_name: anchor_name,
        timeout: timeout
      )

      expect {
        sep10.verify_challenge_tx(
          challenge_xdr: challenge,
          server: server_kp
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        "Transaction not signed by client: %s" % [client_kp.address]
      )
    end
  end

  describe "#verify_challenge_tx_signers" do
    it "returns expected signatures" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp_a,
        anchor_name: anchor_name,
        timeout: timeout
      )

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")
      challenge_envelope.signatures += [
        client_kp_a, client_kp_b, client_kp_c
      ].map { |kp| challenge_envelope.tx.sign_decorated(kp) }

      signers = Set[
        client_kp_a.address,
        client_kp_b.address,
        client_kp_c.address,
        Stellar::KeyPair.random.address
      ]
      signers_found = sep10.verify_challenge_tx_signers(
        challenge_xdr: challenge_envelope.to_xdr(:base64),
        server: server_kp,
        signers: signers
      )
      expect(signers_found).to eql(Set[
        client_kp_a.address,
        client_kp_b.address,
        client_kp_c.address,
      ])
    end

    it "raises no signers error" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp_a,
        anchor_name: anchor_name,
        timeout: timeout
      )

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")
      challenge_envelope.signatures += [
        client_kp_a, client_kp_b, client_kp_c
      ].map { |kp| challenge_envelope.tx.sign_decorated(kp) }

      expect {
        sep10.verify_challenge_tx_signers(
          challenge_xdr: challenge_envelope.to_xdr(:base64),
          server: server_kp,
          signers: Set.new
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /No signers provided./
      )
    end

    it "raises transaction not signed by server" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp_a,
        anchor_name: anchor_name,
        timeout: timeout
      )

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")
      challenge_envelope.signatures = [client_kp_a, client_kp_b, client_kp_c].map { |kp|
        challenge_envelope.tx.sign_decorated(kp)
      }

      signers = Set[
        client_kp_a.address,
        client_kp_b.address,
        client_kp_c.address
      ]

      expect {
        sep10.verify_challenge_tx_signers(
          challenge_xdr: challenge_envelope.to_xdr(:base64),
          server: server_kp,
          signers: signers
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /The transaction is not signed by the server/
      )
    end

    it "raises no client signers found" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp_a,
        anchor_name: anchor_name,
        timeout: timeout
      )

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")
      challenge_envelope.signatures += [
        client_kp_a, client_kp_b, client_kp_c
      ].map { |kp| challenge_envelope.tx.sign_decorated(kp) }

      # Different signers than those on the transaction envelope
      signers = Set[
        Stellar::KeyPair.random.address,
        Stellar::KeyPair.random.address,
        Stellar::KeyPair.random.address
      ]

      expect {
        sep10.verify_challenge_tx_signers(
          challenge_xdr: challenge_envelope.to_xdr(:base64),
          server: server_kp,
          signers: signers
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /Transaction not signed by any client signer./
      )
    end

    it "raises unrecognized signatures" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp_a,
        anchor_name: anchor_name,
        timeout: timeout
      )

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")
      # Add random signature
      challenge_envelope.signatures += [
        client_kp_a, client_kp_b, client_kp_c, Stellar::KeyPair.random
      ].map { |kp| challenge_envelope.tx.sign_decorated(kp) }

      signers = Set[
        client_kp_a.address,
        client_kp_b.address,
        client_kp_c.address
      ]

      expect {
        sep10.verify_challenge_tx_signers(
          challenge_xdr: challenge_envelope.to_xdr(:base64),
          server: server_kp,
          signers: signers
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /Transaction has unrecognized signatures./
      )
    end

    it "raises an error when transaction only has server signature" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp,
        anchor_name: "SDF",
        timeout: 600
      )

      expect {
        sep10.verify_challenge_tx_signers(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[server_kp.address]
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /At least one signer with a G... address must be provied/
      )
    end

    it "succeeds even when the server is included in the passed signers" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures += [challenge_envelope.tx.sign_decorated(client_kp)]
      challenge = challenge_envelope.to_xdr(:base64)

      expect(
        sep10.verify_challenge_tx_signers(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[server_kp.address, client_kp.address]
        )
      ).to eql(
        Set[client_kp.address]
      )
    end

    it "succeeds with extra signers passed" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp_a,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures += [
        challenge_envelope.tx.sign_decorated(client_kp_a),
        challenge_envelope.tx.sign_decorated(client_kp_b)
      ]
      challenge = challenge_envelope.to_xdr(:base64)

      expect(
        sep10.verify_challenge_tx_signers(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[
            client_kp_a.address,
            client_kp_b.address,
            client_kp_c.address
          ]
        )
      ).to eql(
        Set[client_kp_a.address, client_kp_b.address]
      )
    end

    it "does not pass back duplicate signers" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures += [challenge_envelope.tx.sign_decorated(client_kp)]
      challenge = challenge_envelope.to_xdr(:base64)

      expect(
        sep10.verify_challenge_tx_signers(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[client_kp.address, client_kp.address]
        )
      ).to eql(
        Set[client_kp.address]
      )
    end

    it "raises an error for duplicate signatures" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures += [
        challenge_envelope.tx.sign_decorated(client_kp),
        challenge_envelope.tx.sign_decorated(client_kp)
      ]
      challenge = challenge_envelope.to_xdr(:base64)

      expect {
        sep10.verify_challenge_tx_signers(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[server_kp.address, client_kp.address]
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /Transaction has unrecognized signatures./
      )
    end

    it "ignores non-G address" do
      preauth_tx_hash = "TAQCSRX2RIDJNHFIFHWD63X7D7D6TRT5Y2S6E3TEMXTG5W3OECHZ2OG4"
      x_hash = "XDRPF6NZRR7EEVO7ESIWUDXHAOMM2QSKIQQBJK6I2FB7YKDZES5UCLWD"
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures += [challenge_envelope.tx.sign_decorated(client_kp)]
      challenge = challenge_envelope.to_xdr(:base64)

      expect(
        sep10.verify_challenge_tx_signers(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[client_kp.address, preauth_tx_hash, x_hash]
        )
      ).to eql(
        Set[client_kp.address]
      )
    end

    it "raises an error for no signatures" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(
        sep10.build_challenge_tx(
          server: server_kp,
          client: client_kp,
          anchor_name: "SDF",
          timeout: 600
        ),
        "base64"
      )
      challenge_envelope.signatures.clear
      challenge = challenge_envelope.to_xdr(:base64)

      expect {
        sep10.verify_challenge_tx_signers(
          challenge_xdr: challenge,
          server: server_kp,
          signers: Set[client_kp.address]
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /The transaction is not signed by the server/
      )
    end
  end

  describe "#verify_tx_signatures" do
    it "returns expected signatures" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      client_kp_b = Stellar::KeyPair.random
      client_kp_c = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp_a,
        anchor_name: anchor_name,
        timeout: timeout
      )

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")

      challenge_envelope.signatures += [
        client_kp_a, client_kp_b, client_kp_c
      ].map { |kp| challenge_envelope.tx.sign_decorated(kp) }

      signers = Set[
        client_kp_a.address,
        client_kp_b.address,
        client_kp_c.address,
        Stellar::KeyPair.random.address
      ]
      signers_found = sep10.verify_tx_signatures(
        tx_envelope: challenge_envelope, signers: signers
      )
      expect(signers_found).to eql(Set[
        client_kp_a.address,
        client_kp_b.address,
        client_kp_c.address
      ])
    end

    it "raises no signature error" do
      server_kp = Stellar::KeyPair.random
      client_kp = Stellar::KeyPair.random
      value = SecureRandom.base64(48)

      tx = Stellar::TransactionBuilder.manage_data(
        source_account: server_kp,
        sequence_number: 0,
        name: "SDF auth",
        value: value
      )

      now = Time.now.to_i
      tx.time_bounds = Stellar::TimeBounds.new(
        min_time: now,
        max_time: now + timeout
      )

      signers = Set[client_kp.address]
      expect {
        sep10.verify_tx_signatures(
          tx_envelope: tx.to_envelope, signers: signers
        )
      }.to raise_error(
        Stellar::InvalidSep10ChallengeError,
        /Transaction has no signatures./
      )
    end

    it "removes duplicate signers" do
      server_kp = Stellar::KeyPair.random
      client_kp_a = Stellar::KeyPair.random
      timeout = 600
      anchor_name = "SDF"

      challenge = sep10.build_challenge_tx(
        server: server_kp,
        client: client_kp_a,
        anchor_name: anchor_name,
        timeout: timeout
      )

      challenge_envelope = Stellar::TransactionEnvelope.from_xdr(challenge, "base64")

      # Sign the transaction with the same keypair twice
      challenge_envelope.signatures += [
        client_kp_a, client_kp_a
      ].map { |kp| challenge_envelope.tx.sign_decorated(kp) }

      signers = Set[
        client_kp_a.address,
        client_kp_a.address,
        Stellar::KeyPair.random.address
      ]
      signers_found = sep10.verify_tx_signatures(
        tx_envelope: challenge_envelope, signers: signers
      )
      expect(signers_found).to eql(Set[client_kp_a.address])
    end
  end

  describe "#verify_tx_signed_by" do
    let(:keypair) { Stellar::KeyPair.random }
    let(:envelope) do
      Stellar::TransactionBuilder.bump_sequence(
        source_account: keypair,
        bump_to: 1000,
        sequence_number: 0
      ).to_envelope(keypair)
    end

    it "returns true if transaction envelope is signed by keypair" do
      result = sep10.verify_tx_signed_by(tx_envelope: envelope, keypair: keypair)
      expect(result).to eql(true)
    end

    it "returns false if transaction envelope is not signed by keypair" do
      result = sep10.verify_tx_signed_by(
        tx_envelope: envelope,
        keypair: Stellar::KeyPair.random
      )
      expect(result).to eql(false)
    end
  end
end
