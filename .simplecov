require "simplecov-lcov"
require "simplecov-tailwindcss"

SimpleCov::Formatter::LcovFormatter.config do |c|
  c.report_with_single_file = true
  c.single_report_path = "coverage/lcov.info"
end

def start_simplecov
  SimpleCov.formatter = if ENV.key?("CI")
    SimpleCov::Formatter::LcovFormatter
  else
    SimpleCov::Formatter::TailwindFormatter
  end

  SimpleCov.start do
    enable_coverage_for_eval if coverage_for_eval_supported?
    enable_coverage(:branch)
  end
end

start_simplecov if ENV.fetch("COVERAGE", "false") == "true"
