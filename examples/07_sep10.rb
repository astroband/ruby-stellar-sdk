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

setup_multisig