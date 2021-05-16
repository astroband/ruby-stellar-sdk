class << Stellar::Account
  deprecate deprecator: Stellar::SdkDeprecation, lookup: "Use `Stellar::Federation.lookup` method"
end
