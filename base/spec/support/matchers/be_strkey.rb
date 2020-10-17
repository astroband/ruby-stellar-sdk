RSpec::Matchers.define :be_strkey do |version_byte|
  match do |actual|
    Stellar::Util::StrKey.check_decode(version_byte, actual)
  rescue ArgumentError
    false
  end
end
