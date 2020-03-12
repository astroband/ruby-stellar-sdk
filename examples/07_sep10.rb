require 'stellar-sdk'
require 'hyperclient'

$client = Stellar::Client.default_testnet
$client_master_kp = Stellar::KeyPair.random
$client_signer_kp1 = Stellar::KeyPair.random
$client_signer_kp2 = Stellar::KeyPair.random
$server_kp = Stellar::KeyPair.random

def setup_multisig
  account = Stellar::Account.from_seed($client_master_kp.seed)
  $client.friendbot(account)
  $client.load_account_signers(account)

  signer1 = Stellar::Signer.new
  signer1.key = Stellar::SignerKey.ed25519($client_signer_kp1)
  signer1.weight = 1

  add_signer2_op = Stellar::SetOptionsOp.new
  add_signer2_op.signer = Stellar::Signer.new
  add_signer2_op.signer.key = Stellar::SignerKey.ed25519($client_signer_kp2)
  add_signer2_op.signer.weight = 1
  op2 = Stellar::Operation.new
  op2.body = Stellar::Operation::Body.new(:set_options, add_signer2_op)

  set_thresholds_op = Stellar::SetOptionsOp.new
  set_thresholds_op.low_threshold = 1
  set_thresholds_op.med_threshold = 2
  set_thresholds_op.high_threshold = 3
  op3 = Stellar::Operation.new
  op3.body = Stellar::Operation::Body.new(:set_options, set_thresholds_op)

  account_info = $client.account_info(account)
  seq_num = account_info.sequence.to_i + 1
  tx = Stellar::Transaction.make(:set_options, {
    :account => $client_master_kp,
    :sequence => seq_num,
    :signer => signer1,
    :fee => 100 * 3
  })
  tx.operations += [op2, op3]

  envelope_xdr = tx.to_envelope($client_master_kp).to_xdr(:base64)
  begin
    $client.horizon.transactions._post(tx: envelope_xdr)
  rescue Faraday::ClientError => e
    p e.response
  end
end


# This function walks throught the steps both the wallet and server would take
# during a SEP-10 challenge verification.
def example_verify_challenge_tx_threshold
  # 1. The wallet makes a GET request to /auth,
  # 2. The server receives the request, and returns the challenge xdr.
  envelope_xdr = Stellar::SEP10.build_challenge_tx(
    server: $server_kp,
    client: $client_master_kp,
    anchor_name: "SDF",
    timeout: 600
  )
  # 3. The wallet recieves the challenge xdr and collects enough signatures from
  #    the accounts signers to reach the medium threshold on the account.
  #    `envelope.signatures` already contains the server's signature, so the wallet 
  #    adds to the list.
  envelope = Stellar::TransactionEnvelope.from_xdr(envelope_xdr, "base64")
  envelope.signatures += [
    envelope.tx.sign_decorated($client_signer_kp1),
    envelope.tx.sign_decorated($client_signer_kp2)
  ]
  envelope_xdr = envelope.to_xdr(:base64)

  # 4. The wallet makes a POST request to /auth containing the signed challenge
  # 5. The server verifies the challenge transaction
  envelope, client_master_address = Stellar::SEP10.read_challenge_tx(
    challenge: envelope_xdr,
    server: $server_kp
  )
  client_account = Stellar::Account.from_address(client_master_address)
  client.load_account_signers(account)
  

end

setup_multisig