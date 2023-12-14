require "simplecov_json_formatter"
require "simplecov-lcov"

SimpleCov::Formatter::LcovFormatter.config do |c|
  c.report_with_single_file = true
  c.single_report_path = "coverage/lcov.info"
end

def start_simplecov
  formatters = [
    SimpleCov::Formatter::LcovFormatter,
    SimpleCov::Formatter::JSONFormatter
  ]

  unless ENV.key?("CI")
    require "simplecov-cobertura"
    require "simplecov-tailwindcss"

    formatters << SimpleCov::Formatter::CoberturaFormatter
    formatters << SimpleCov::Formatter::TailwindFormatter
  end

  SimpleCov.formatters = formatters

  SimpleCov.start do
    enable_coverage_for_eval if coverage_for_eval_supported?
    enable_coverage(:branch)

    track_files "**/*.rb"

    # add_filter "examples/"
    # add_filter "spec/"

    add_group "Base", "base"
    add_group "Horizon", "horizon"
    add_group "SDK", "sdk"
  end
end

start_simplecov if ENV.fetch("COVERAGE", "false") == "true"
