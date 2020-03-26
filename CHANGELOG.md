# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

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
