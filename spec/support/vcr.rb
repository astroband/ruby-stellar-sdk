require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  %i[source_address channel_address].each do |var|
    config.filter_sensitive_data("[#{var}]") { CONFIG[var] }
  end
end
