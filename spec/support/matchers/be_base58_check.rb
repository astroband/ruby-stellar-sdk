RSpec::Matchers.define :be_base58_check do |version_byte|
  match do |actual|
    begin
      Stellar::Util::Base58.stellar.check_decode(version_byte, actual)
    rescue ArgumentError
      false
    end
  end
end