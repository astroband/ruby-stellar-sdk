# frozen_string_literal: true

require "standard/rake"
require "bundler/audit/task"

Bundler::Audit::Task.new

##
# Linters for multi-gem monorepo setup
#
namespace :lint do
  desc "Verifies code style and quality with `standard` gem"
  task code: %i[standard]

  desc "Check dependencies with bundle-audit"
  task deps: %i[bundle:audit]

  desc "Validates docs for a single gem, e.g. lint:docs:base"
  task "docs:*"

  rule(/docs:.+$/) do |task|
    sh("cd #{task.name.split(":").last} && bundle exec yard-junk")
  end

  desc "Validate documentation with yard-junk for all gems"
  task docs: %i[lint:docs:base lint:docs:sdk]

  desc "Run all code quality checks"
  task all: %i[code deps docs]
end
