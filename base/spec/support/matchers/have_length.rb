RSpec::Matchers.define :have_length do |length|
  match do |actual|
    actual.length == length
  end
end