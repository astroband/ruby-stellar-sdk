def start_simplecov
  formatters = SimpleCov.formatters
  if ENV.key?("CI") && Bundler.current_ruby.ruby_27?
    require "codecov"
    formatters << SimpleCov::Formatter::Codecov
  end

  SimpleCov.formatters = formatters

  SimpleCov.start do
    enable_coverage(:branch)
  end
end

start_simplecov if ENV.fetch("COVERAGE", "false") == "true"
