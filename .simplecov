require "simplecov-lcov"

SimpleCov::Formatter::LcovFormatter.config do |c|
  c.report_with_single_file = true
  c.single_report_path = "coverage/lcov.info"
end

def start_simplecov
  formatters = SimpleCov.formatters

  if ENV.key?("CI")
    require "codecov"

    formatters << SimpleCov::Formatter::LcovFormatter
    formatters << SimpleCov::Formatter::Codecov
  end

  SimpleCov.formatters = formatters

  SimpleCov.start do
    enable_coverage(:branch)
  end
end

start_simplecov if ENV.fetch("COVERAGE", "false") == "true"
