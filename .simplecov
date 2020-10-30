if ENV.key?("CI")
  require "codecov"
  require "simplecov_json_formatter"

  # This is a workaround for CodeClimate incompatibility with SimpleCov 0.18+. More info:
  # - https://github.com/codeclimate/test-reporter/issues/413
  # - https://github.com/simplecov-ruby/simplecov/pull/923
  module SimpleCovJSONFormatter
    class ResultExporter
      def json_result
        coverage = @result[:coverage].transform_values { |v| v[:lines] }
        JSON.pretty_generate({SimpleCov.project_name => {coverage: coverage, timestamp: Time.now.to_i}})
      end
      private :json_result
    end
  end

  SimpleCov.formatters = [
    SimpleCov::Formatter::JSONFormatter, # for CodeClimate test coverage
    SimpleCov::Formatter::Codecov
  ]
end

SimpleCov.start
