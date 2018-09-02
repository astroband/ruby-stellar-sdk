# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Changed
- Update stellar-base to `>= 0.16.0`
- Update hyperclient, excon, contracts, activesupport

### Fixed
- `#create_account`, along with `#send_payment`

### Added
- `Stellar::Client#change_trust` to create, update, delete a trustline
- `Stellar::Client#account_merge` to merge accounts
