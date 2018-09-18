# Changelog

All notable changes to this project will be documented in this
file.  This project adheres to [Semantic Versioning](http://semver.org/).

As this project is pre 1.0, breaking changes may happen for minor version
bumps.  A breaking change will get clearly notified in this log.

## [unreleased](https://github.com/stellar/ruby-stellar-base/compare/v0.17.0...master)
### Added
- Update XDR definitions for stellar-core v10.0.0 (introduces Liabilities and other changes to support asset-backed offers as per [CAP-0003 Specification](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0003.md#specification))

## [0.17.0](https://github.com/stellar/ruby-stellar-base/compare/v0.16.0...v0.17.0)
### Fixed
- Rename `Stellar::SignerKey#onetime_signer` helper to `Stellar::SignerKey#hash_x`, add preimage validations

## [0.16.0](https://github.com/stellar/ruby-stellar-base/compare/v0.15.0...v0.16.0)
### Added
- Create co-signers conveniently using helpers `ed25519(keypair)`, `preauthorized_transaction(tx)` and `onetime_signer(preimage)` from `Stellar::SignerKey` module
- Merge two transactions with `Stellar::TransactionEnvelope#merge`

### Fixed
- Source account overriding in Stellar::Transaction#to_operations

## [0.15.0](https://github.com/stellar/ruby-stellar-base/compare/v0.14.0...v0.15.0)
### Added
- `Stellar::Operation.change_trust` can accept `Stellar::Asset` instance for `line`

### Fixed
- Protect `Stellar::Operation.change_trust` against malicious arguments, in the event that developers pass this argument directly from user input

## [0.14.0](https://github.com/stellar/ruby-stellar-base/compare/v0.13.0...v0.14.0)

### Added
- We now support the bump sequence operation with `Operation.bump_sequence`.

### Changed
- Update XDR definitions for stellar-core 0.10.0 support
- `Operation.change_trust` learned how to use a default for the `:limit` parameter
- `StrKey` learned about new version bytes `pre_auth_tx` and `hash_x`

## [0.13.0](https://github.com/stellar/ruby-stellar-base/compare/v0.12.0...v0.13.0)

### Changed
- Update XDR definitions for stellar-core 0.9.1 support

### Added
- Added `#signer_key` helper to `KeyPair`

## [0.12.0](https://github.com/stellar/ruby-stellar-base/compare/v0.11.0...v0.12.0)

### Changed
- Avoid modifying $LOAD_PATH to fix load order issues
- Update XDR definitions for stellar-core 0.6 support

### Removed

- BREAKING CHANGE: Removed support for JRuby.

## [0.11.0](https://github.com/stellar/ruby-stellar-base/compare/v0.10.0...v0.11.0)

### Added
- Added support for `manage_data` operations

### Changed
- `Stellar::Transaction#to_envelope` can now be used without arguments, returning a `Stellar::TransactionEnvelope` with zero signatures.

## [0.10.0](https://github.com/stellar/ruby-stellar-base/compare/v0.9.0...v0.10.0)

- Added memo helpers to `Stellar::Transaction.for_account`, allowing any operation builder (such as `Stellar::Transaction.payment) to provide a custom memo using the `:memo` attribute.  

## [0.9.0](https://github.com/stellar/ruby-stellar-base/compare/v0.8.0...v0.9.0)

### Changed
- XDR Definitions have been updated to stellar-core commit eed89649c2060b8e9dacffe2cec4e8b258b32416

## [0.8.0](https://github.com/stellar/ruby-stellar-base/compare/v0.7.0...v0.8.0)

### Changed
- BREAKING CHANGE:  The default network for this library is now the stellar test network.  
  To enable this library for the production network use `Stellar.default_network = Stellar::Networks::PUBLIC`
  at the head of your script or in your configuration function.

## [0.7.0](https://github.com/stellar/ruby-stellar-base/compare/v0.6.1...v0.7.0)

### Changed

- Bump xdr dependency to 1.0.0

## [0.6.1](https://github.com/stellar/ruby-stellar-base/compare/v0.6.0...v0.6.1)

### Changed

- Update default fee for transactions to new minimum of 100 stroops


## [0.6.0](https://github.com/stellar/ruby-stellar-base/compare/v0.5.0...v0.6.0)

### Changed

- Update to latest xdr (stellar-core commit ad22bccafbbc14a358f05a989f7b95714dc9d4c6)

## [0.5.0](https://github.com/stellar/ruby-stellar-base/compare/v0.4.0...v0.5.0)

### Changed

- Update to latest xdr

## [0.4.0](https://github.com/stellar/ruby-stellar-base/compare/v0.3.0...v0.4.0)

### Changed
- BREAKING CHANGE: "Amounts", that is, input parameters that represent a
  certain amount of a given asset, such as the `:starting_balance` option for
  `Operation.create_account` are now interpreted using the convention of 7
  fixed-decimal places.  For example, specifying a payment where the amount is
  `50` will result in a transaction with an amount set to `500000000`.
