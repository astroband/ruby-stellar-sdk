# Changelog

All notable changes to this project will be documented in this
file. The format is based on [Keep a Changelog](https://keepachangelog.com/)
and this project adheres to [Semantic Versioning](https://semver.org/).

As this project is pre 1.0, breaking changes may happen for minor version
bumps.  A breaking change will get clearly notified in this log.

## [0.30.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.29.0...v0.30.0) (2021-10-14)
### Added
* `Stellar::Horizon::Problem` class moved to `stellar-horizon` gem from `stellar-sdk`
* `Stellar::TransactionPage` from `stellar-sdk` is now `Stellar::Horizon::TransactionPage` in `stellar-horizon` gem
* `faraday` and `faraday_middleware` are now direct dependencies

### Changed
* `stellar-horizon` no longer depends on `stellar-sdk` (dependency has been reversed)

## [0.29.0](https://github.com/astroband/ruby-stellar-sdk/compare/v0.28.0...v0.29.0) (2021-09-07)

### Added
* Initial setup of the gem, copying all Horizon-related features from `sdk` gem
