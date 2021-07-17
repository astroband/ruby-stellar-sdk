# Changelog

All notable changes to this project will be documented in this
file. The format is based on [Keep a Changelog](https://keepachangelog.com/)
and this project adheres to [Semantic Versioning](https://semver.org/).

As this project is pre 1.0, breaking changes may happen for minor version
bumps.  A breaking change will get clearly notified in this log.

## [0.28.0](https://www.github.com/astroband/ruby-stellar-sdk/compare/v0.27.0...v0.28.0) (2021-07-17)

### Features

* support muxed accounts in tx builder ([#162](https://www.github.com/astroband/ruby-stellar-sdk/issues/162)) ([37cd954](https://www.github.com/astroband/ruby-stellar-sdk/commit/37cd954f92c7999a74ca779e795dde74a3d71aad))

## [0.27.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.26.0...v0.27.0) (2021-05-08)

### Features

* **protocol:** support Stellar protocol 17 ([#137](https://www.github.com/astroband/ruby-stellar-sdk/issues/137)) ([5fea84d](https://www.github.com/astroband/ruby-stellar-sdk/commit/5fea84d8c3b10b7afc00a10415e8fea01c25eec7))

## [0.26.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.25.0...v0.26.0) - 2021-02-05
- No changes

## [0.25.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.24.0...v0.25.0) - 2020-10-30
### Added
- `MuxedAccount` implements `#to_keypair` conversion protocol
- `MuxedAccount` correctly responds to `#address` with strkey encoded public key
### Fixed
- `Transaction::V0#source_account` now properly returns `MuxedAccount` instead of raw bytes

## [0.24.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.23.1...v0.24.0) - 2020-10-20
### Added
- Add conversion methods for KeyPair and Asset
- Stellar Protocol 14 support
  - Regenerate XDR wrappers from definitions in stellar-core 14.1.1
  - Add [CAP-23 Two-Part Payments](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0023.md) support
      - Add ClaimPredicate DSL methods which help with creation of claim predicates.
        ```ruby
        # use class-level helpers to create simple predicates
        unconditional   = Stellar::ClaimPredicate.unconditional
        before_rel_time = Stellar::ClaimPredicate.before_relative_time(1.hour)
        before_abs_time = Stellar::ClaimPredicate.before_absolute_time(Date.tomorrow.beginning_of_day)

        # negate predicates using `~` unary operator
        ~predicate # same as predicate.not

        # build complex predicates using `&` and `|` infix operators
        predicate & other_predicate # same as `predicate.and(other_predicate)`
        predicate | other_predicate # same as `predicate.or(other_predicate)`

        # quickly define complex predicates using `.compose` class method with the block
        unconditional = Stellar::ClaimPredicate.compose { }
        complex = Stellar::ClaimPredicate.compose do
          before_relative_time(1.week) & ~before_relative_time(10.seconds) |
        end

        # here's what building this predicate would look like without DSL
        complex = Stellar::ClaimPredicate.new(
            Stellar::ClaimPredicateType::AND,
            Stellar::ClaimPredicate.new(
                Stellar::ClaimPredicateType::BEFORE_RELATIVE_TIME, 7 * 24 * 60 * 60
            ),
            Stellar::ClaimPredicate.new(
                Stellar::ClaimPredicateType::NOT, Stellar::ClaimPredicate.new(
                    Stellar::ClaimPredicateType::BEFORE_RELATIVE_TIME, 10
                )
            )
        )

        ```
      - Extend Operation with `create_claimable_balance` and `claim_claimable_balance` helpers
      - Add Claimant and ClaimPredicate DSL methods to reduce the noise.
        ```ruby
        include Stellar::DSL

        sender = KeyPair('S....')
        recipient = 'G....'

        op = Operation.create_claimable_balance(
            asset: Stellar::Asset.native,
            amount: 100,
            claimants: [
              Claimant(recipient) { after(10.seconds) & before(1.week) },
              Claimant(sender), # allow unconditional claim-back
            ]
          )
        ])
        ```
      - Add simple predicate evaluation feature so that developers can sanity-check their predicates
        ```ruby
        include Stellar::DSL

        predicate = ClaimPredicate { before_relative_time(1.week) & ~before_relative_time(10.seconds) }

        # predicate.evaluate(balance_creation_time, claim_evaluation_time)
        predicate.evaluate("2020-10-20 09:00:00", "2020-10-20 09:00:05") # => false
        predicate.evaluate("2020-10-20 09:00:00", "2020-10-20 09:01:00") # => true
        predicate.evaluate("2020-10-20 09:00:00", "2020-10-27 08:50:00") # => true

        # you can also pass an instance of ActiveSupport::Duration as a second parameter, in this case
        # it works as a relative offset from `balance_creation_time`
        predicate.evaluate("2020-10-20 09:00:00", 1.week + 1.second) # => false

        # it is effectively the same as
        predicate.evaluate("2020-10-20 09:00:00", "2020-10-27 09:00:01") # => false
        ```
  - Add [CAP-33 Sponsored Reserves](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0033.md) support
    - Extend the operation class with helpers that allow sponsoring reserves and also revoke sponsorships.
      - `Operation.begin_sponsoring_future_reserves`
      - `Operation.end_sponsoring_future_reserves`
      - `Operation.revoke_sponsorship(account_id:)`
      - `Operation.revoke_sponsorship(account_id:, asset:)`
      - `Operation.revoke_sponsorship(account_id:, offer_id:)`
      - `Operation.revoke_sponsorship(account_id:, data_name:)`
      - `Operation.revoke_sponsorship(account_id:, balance_id:)`
      - `Operation.revoke_sponsorship(account_id:, signer:)`


## [0.23.1](https://github.com/astroband/ruby-stellar-sdk/compare/v0.23.0...v0.23.1) - 2020-06-18
### Added
- Transaction builder now builds V1 transactions
- FeeBumpTransaction can wrap V0 transaction

## [0.23.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.22.0...v0.23.0) - 2020-06-11
### Added
- Stellar Protocol 13 support
  - Fee-Bump transactions ([CAP-0015](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0015.md))
  - Multiplexed accounts ([CAP-0027](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0027.md))
  - Fine-Grained control on trustline authorization ([CAP-0018](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0018.md))

## [0.22.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.21.0...base-v0.22.0) - 2020-03-26
### Added
- Add TransactionBuilder ([#54](https://github.com/astroband/ruby-stellar-base/issues/54))

### Changed
- Regenerate XDR files ([#57](https://github.com/astroband/ruby-stellar-base/issues/57))
- Allow asset objects to be passed instead of list of parameters ([#59](https://github.com/astroband/ruby-stellar-base/issues/59))

## [0.21.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.20.0...base-v0.21.0) - 2019-10-04
### Changed
- [Stellar Protocol 12 compatibility](https://github.com/astroband/ruby-stellar-base/pull/51).
  - XDR changes for path payment
  - constant renames, which may cause breaking changes if referred to directly

## [0.20.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.19.0...base-v0.20.0) - 2019-05-22
### Added
- Stellar Protocol 11 compatibility (#48)
  - XDR changes for [CAP-0006 Buy Offers](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0006.md)
  - XDR changes for [CAP-0020 Bucket Initial Entries](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0020.md)
  - Add `manage_buy_offer`, `manage_sell_offer` and `create_passive_sell_offer` factory methods to `Stellar::Transaction` and `Stellar::Operation`

### Changed
- Deprecate `manage_offer` and `create_passive_offer` factory methods in `Stellar::Transaction` and `Stellar::Operation`
- Add an option to pass the exact stellar-core revision into `xdr:update` Rake task

## [0.19.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.18.0...base-v0.19.0)
### Changed
- Loosen ActiveSupport to >= 5.0.0

## [0.18.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.17.0...base-v0.18.0)
### Added
- Update XDR definitions for stellar-core v10.0.0 (introduces Liabilities and other changes to support asset-backed offers as per [CAP-0003 Specification](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0003.md#specification))
- Add factories for ledger, transaction, operation.

### Changed
- Use rbnacl instead of rbnacl-libsodium (the latter has been [deprecated](https://github.com/crypto-rb/rbnacl-libsodium/issues/29))

## [0.17.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.16.0...base-v0.17.0)
### Fixed
- Rename `Stellar::SignerKey#onetime_signer` helper to `Stellar::SignerKey#hash_x`, add preimage validations

## [0.16.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.15.0...base-v0.16.0)
### Added
- Create co-signers conveniently using helpers `ed25519(keypair)`, `preauthorized_transaction(tx)` and `onetime_signer(preimage)` from `Stellar::SignerKey` module
- Merge two transactions with `Stellar::TransactionEnvelope#merge`

### Fixed
- Source account overriding in Stellar::Transaction#to_operations

## [0.15.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.14.0...base-v0.15.0)
### Added
- `Stellar::Operation.change_trust` can accept `Stellar::Asset` instance for `line`

### Fixed
- Protect `Stellar::Operation.change_trust` against malicious arguments, in the event that developers pass this argument directly from user input

## [0.14.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.13.0...base-v0.14.0)

### Added
- We now support the bump sequence operation with `Operation.bump_sequence`.

### Changed
- Update XDR definitions for stellar-core 0.10.0 support
- `Operation.change_trust` learned how to use a default for the `:limit` parameter
- `StrKey` learned about new version bytes `pre_auth_tx` and `hash_x`

## [0.13.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.12.0...base-v0.13.0)

### Changed
- Update XDR definitions for stellar-core 0.9.1 support

### Added
- Added `#signer_key` helper to `KeyPair`

## [0.12.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.11.0...base-v0.12.0)

### Changed
- Avoid modifying $LOAD_PATH to fix load order issues
- Update XDR definitions for stellar-core 0.6 support

### Removed

- BREAKING CHANGE: Removed support for JRuby.

## [0.11.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.10.0...base-v0.11.0)

### Added
- Added support for `manage_data` operations

### Changed
- `Stellar::Transaction#to_envelope` can now be used without arguments, returning a `Stellar::TransactionEnvelope` with zero signatures.

## [0.10.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.9.0...base-v0.10.0)

- Added memo helpers to `Stellar::Transaction.for_account`, allowing any operation builder (such as `Stellar::Transaction.payment) to provide a custom memo using the `:memo` attribute.

## [0.9.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.8.0...base-v0.9.0)

### Changed
- XDR Definitions have been updated to stellar-core commit eed89649c2060b8e9dacffe2cec4e8b258b32416

## [0.8.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.7.0...base-v0.8.0)

### Changed
- BREAKING CHANGE:  The default network for this library is now the stellar test network.
  To enable this library for the production network use `Stellar.default_network = Stellar::Networks::PUBLIC`
  at the head of your script or in your configuration function.

## [0.7.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.6.1...base-v0.7.0)

### Changed

- Bump xdr dependency to 1.0.0

## [0.6.1](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.6.0...base-v0.6.1)

### Changed

- Update default fee for transactions to new minimum of 100 stroops


## [0.6.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.5.0...base-v0.6.0)

### Changed

- Update to latest xdr (stellar-core commit ad22bccafbbc14a358f05a989f7b95714dc9d4c6)

## [0.5.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.4.0...base-v0.5.0)

### Changed

- Update to latest xdr

## [0.4.0](https://github.com/astroband/ruby-stellar-sdk/compare/base-v0.3.0...base-v0.4.0)

### Changed
- BREAKING CHANGE: "Amounts", that is, input parameters that represent a
  certain amount of a given asset, such as the `:starting_balance` option for
  `Operation.create_account` are now interpreted using the convention of 7
  fixed-decimal places.  For example, specifying a payment where the amount is
  `50` will result in a transaction with an amount set to `500000000`.
