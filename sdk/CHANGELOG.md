# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.30.0](https://www.github.com/astroband/ruby-stellar-sdk/compare/v0.29.0...v0.30.0) (2021-10-14)

### Added
* `stellar-sdk` now depends on `stellar-horizon`
### Changed
* `Stellar::Amount` class moved to `stellar-base` gem
* `Stellar::Horizon::Problem` class moved to `stellar-horizon` gem
* `Stellar::TransactionPage` is now `Stellar::Horizon::TransactionPage` in `stellar-horizon` gem
* `toml-rb` gem is replaced with `tomlrb` gem to work around [segfaults in Ruby 3.0](https://github.com/mjackson/citrus/issues/60)

## [0.29.0](https://www.github.com/astroband/ruby-stellar-sdk/compare/v0.28.0...v0.29.0) (2021-09-07)

### Added
* support for client domain in SEP-10
### Deprecated
* `Stellar::Client` class is marked as deprecated in favour of new `stellar-horizon` gem

## [0.28.0](https://www.github.com/astroband/ruby-stellar-sdk/compare/v0.27.0...v0.28.0) (2021-07-17)

### Changed
* `Stellar::Account` class is now part of `stellar-base` gem
* `Stellar::Account.lookup` is deprecated, use `Stellar::Federation.lookup` instead

## [0.27.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.26.0...v0.27.0) (2021-05-08)
- No changes

## [0.26.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.25.0...v0.26.0) - 2021-02-05
### Changed
- `Stellar::SEP10` is updated to comply with SEP10 v3.0.0 and v3.1.0
  - `read_challenge_tx`` now verifies `domain` in challenge auth operation, as per SEP10 v3.0.0
  - it is now possible to provide `auth_domain` parameter to enforce auth server domain verification:
    - `build_challenge_tx` will encode the extra auth domain operation into the challenge tx
    - `read_challenge_tx` will verify that the challenge includes the correct auth domain operation

## [0.25.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.24.0...v0.25.0) - 2020-10-30
### Changed
- `Stellar::SEP10` is updated to comply with SEP10 v2.1.0
  - `build_challenge_tx` now accepts `domain` instead of `anchor_name`, using the
    old param name will now result in deprecation warning
  - `read_challenge_tx` correctly validates multi-op challenge transactions
  - `verify_challenge_tx_threshold` now expects simple `{'GA...' => weight, ... }` hash for `signers`
### Removed:
- Deprecated `Stellar::SEP10.verify_challenge_tx` method is removed

## [0.24.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.23.1...v0.24.0) - 2020-10-20
- Protocol 14 support

## [0.23.1](https://github.com/astroband/ruby-stellar-sdk/compare/v0.23.0...v0.23.1) - 2020-06-18
- Fix SEP10, considering muxed accounts

## [0.23.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.9.0-rc.1...v0.23.0)
- No changes. We bumped this version to sync `stellar-sdk` and `stellar-base` versions

## [0.9.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.8.0...v0.9.0-rc.1)
### Added
- Stellar Protocol 13 support
  - Fee-Bump transactions ([CAP-0015](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0015.md))
  - Multiplexed accounts ([CAP-0027](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0027.md))
  - Fine-Grained control on trustline authorization ([CAP-0018](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0018.md))

## [0.8.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.7.0...v0.8.0)
### Added
- SEP-10 Multisig Support [#69](https://github.com/astroband/ruby-stellar-sdk/pull/69)
- `X-Client-Name` and `X-Client-Version` headers

## [0.7.0] - 2019-04-26
### Added
- Friendbot support

## [0.6.0] - 2018-11-27
### Added
- Allow setting of memo in `Stellar::Client#send_payment`
- Optionally send payments through a payment channel with `Stellar::Client#send_payment`
- Clarify variable names for payment channels in `#send_payment`

## [0.5.0] - 2018-07-10
### Changed
- Update stellar-base to `>= 0.16.0`
- Update hyperclient, excon, contracts, activesupport

### Fixed
- `#create_account`, along with `#send_payment`

### Added
- `Stellar::Client#change_trust` to create, update, delete a trustline
- `Stellar::Client#account_merge` to merge accounts
