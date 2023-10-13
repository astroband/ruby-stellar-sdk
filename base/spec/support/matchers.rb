RSpec::Matchers.define :eq_bytes do |expected|
  match do |actual|
    expected.force_encoding("BINARY") == actual.force_encoding("BINARY")
  end
end

RSpec::Matchers.define :eq_hex do |expected|
  match do |actual|
    actual.force_encoding("BINARY").unpack1("H*") == expected
  end

  failure_message do |actual|
    "expected #{actual.unpack1("H*")} to eq #{expected}"
  end
end

RSpec::Matchers.define :be_strkey do |version_byte|
  match do |actual|
    Stellar::Util::StrKey.check_decode(version_byte, actual)
  rescue ArgumentError
    false
  end
end

RSpec::Matchers.define :have_length do |length|
  match do |actual|
    actual.length == length
  end
end
