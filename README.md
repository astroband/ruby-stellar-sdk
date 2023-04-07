# Stellar SDK for Ruby
[![CI](https://github.com/astroband/ruby-stellar-sdk/actions/workflows/ci.yml/badge.svg)](https://github.com/astroband/ruby-stellar-sdk/actions/workflows/ci.yml)
[![CI](https://github.com/astroband/ruby-stellar-sdk/actions/workflows/security.yml/badge.svg)](https://github.com/astroband/ruby-stellar-sdk/actions/workflows/security.yml)
[![Coverage Status](https://coveralls.io/repos/github/astroband/ruby-stellar-sdk/badge.svg?branch=main)](https://coveralls.io/github/astroband/ruby-stellar-sdk?branch=main)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fastroband%2Fruby-stellar-sdk.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fastroband%2Fruby-stellar-sdk?ref=badge_shield)
[![Maintainability](https://api.codeclimate.com/v1/badges/dadfcd9396aba493cb93/maintainability)](https://codeclimate.com/github/astroband/ruby-stellar-sdk/maintainability)

A monorepo Community maintained Ruby SDK for Stellar

### stellar-base
[![stellar-base](https://badge.fury.io/rb/stellar-base.svg)](https://badge.fury.io/rb/stellar-base)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](https://rubydoc.info/gems/stellar-base)

This library provides a low-level interface to read, write,
hash and sign the [XDR structures](https://github.com/stellar/stellar-xdr)
used by [Stellar Protocol](https://github.com/stellar/stellar-protocol).

[Sources](https://github.com/astroband/ruby-stellar-sdk/blob/main/base/README.md)
| [Docs](https://rubydoc.info/gems/stellar-base)
| [Examples](https://github.com/astroband/ruby-stellar-sdk/blob/main/base/examples/)
| [Changelog](https://github.com/astroband/ruby-stellar-sdk/blob/main/base/CHANGELOG.md)

### stellar-horizon
[![stellar-horizon](https://badge.fury.io/rb/stellar-horizon.svg)](https://badge.fury.io/rb/stellar-horizon)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](https://rubydoc.info/gems/stellar-horizon)

A client library for the [Stellar Horizon API](https://developers.stellar.org/api).

[Sources](https://github.com/astroband/ruby-stellar-sdk/blob/main/horizon/README.md)
| [Docs](https://rubydoc.info/gems/stellar-horizon)
| [Changelog](https://github.com/astroband/ruby-stellar-sdk/blob/main/horizon/CHANGELOG.md)

### stellar-sdk
[![stellar-sdk](https://badge.fury.io/rb/stellar-sdk.svg)](https://badge.fury.io/rb/stellar-sdk)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](https://rubydoc.info/gems/stellar-sdk)

A meta-gem which depends on the `stellar-base` and `stellar-horizon` gems.
It provides a convenient way to add full Stellar SDK to your project.

[Sources](https://github.com/astroband/ruby-stellar-sdk/blob/main/sdk/README.md)
| [Docs](https://rubydoc.info/gems/stellar-sdk)
| [Examples](https://github.com/astroband/ruby-stellar-sdk/blob/main/sdk/examples/)
| [Changelog](https://github.com/astroband/ruby-stellar-sdk/blob/main/sdk/CHANGELOG.md)



## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fastroband%2Fruby-stellar-sdk.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fastroband%2Fruby-stellar-sdk?ref=badge_large)
