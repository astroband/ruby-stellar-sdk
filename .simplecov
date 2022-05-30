def start_simplecov
  formatters = SimpleCov.formatters
  if ENV.key?("CI")
    require "codecov"
    formatters << SimpleCov::Formatter::Codecov
  end

  SimpleCov.formatters = formatters

  SimpleCov.start do
    enable_coverage(:branch)
  end
end

start_simplecov if ENV.fetch("COVERAGE", "false") == "true"
