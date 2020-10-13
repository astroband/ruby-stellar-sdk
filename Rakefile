# frozen_string_literal: true

require "bundler/audit/task"
require "standard/rake"

Bundler::Audit::Task.new

GEMS = %w[base sdk]

desc "Run spec task for all projects"
task :spec do
  errors = []
  GEMS.each do |gem|
    system(%(cd #{gem} && bundle exec rake spec --trace)) || errors << gem
  end
  fail("Errors in #{errors.join(", ")}") unless errors.empty?
end

desc "Run code quality checks"
task code_quality: %i[bundle:audit standard]

task default: %i[code_quality spec]
