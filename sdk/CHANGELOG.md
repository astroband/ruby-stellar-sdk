# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased](https://github.com/stellar/ruby-stellar-sdk/compare/v0.23.0...v0.23.1)

## [0.24.0](https://github.com/stellar/ruby-stellar-sdk/compare/v0.23.1...v0.24.0) - 2020-10-20
- Protocol 14 support

## [0.23.1](https://github.com/stellar/ruby-stellar-sdk/compare/v0.23.0...v0.23.1) - 2020-06-18
- Fix SEP10, considering muxed accounts

## [0.23.0](https://github.com/stellar/ruby-stellar-sdk/compare/v0.9.0...v0.23.0)
- No changes. We bumped this version to sync `stellar-sdk` and `stellar-base` versions

## [0.9.0](https://github.com/stellar/ruby-stellar-sdk/compare/v0.9.0...v0.8.0)
### Added
- Stellar Protocol 13 support
  - Fee-Bump transactions ([CAP-0015](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0015.md))
  - Multiplexed accounts ([CAP-0027](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0027.md))
  - Fine-Grained control on trustline authorization ([CAP-0018](https://github.com/stellar/stellar-protocol/blob/master/core/cap-0018.md))
  
## [0.8.0](https://github.com/stellar/ruby-stellar-sdk/compare/v0.7.0...v0.8.0)
### Added
- SEP-10 Multisig Support [#69](https://github.com/stellar/ruby-stellar-sdk/pull/69)
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
