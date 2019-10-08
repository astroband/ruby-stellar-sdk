# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Added
- `X-Client-Name` and `X-Client-Version` headers
- Add SEP0010 transaction challenge builder.
    ```
    client = Stellar::Client.default_testnet
    client.build_challenge_tx(server: server, client: user, anchor_name: anchor, timeout: timeout) 
    ```

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
