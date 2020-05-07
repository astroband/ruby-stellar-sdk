require "simplecov"
SimpleCov.start

require "pry"
require "stellar-sdk"
require "pathname"

SPEC_ROOT = Pathname.new(File.dirname(__FILE__))

Dir["#{SPEC_ROOT}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
end
