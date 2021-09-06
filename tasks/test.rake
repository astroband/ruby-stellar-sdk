# frozen_string_literal: true

##
# Testing tasks for multi-gem monorepo setup
#
namespace :test do
  desc "Executes specs for a single gem, e.g. spec:base"
  task "spec:*"

  rule(/spec:.+$/) do |task|
    sh("cd #{task.name.split(":").last} && ../bin/rspec")
  end

  desc "Run spec task for all projects"
  task spec: %i[spec:base spec:sdk spec:horizon]

  rule(/coverage:.+$/) do |task|
    sh("cd #{task.name.split(":").last} && COVERAGE=true ../bin/rspec")
  end

  desc "Generate code coverage for all projects"
  task coverage: %i[coverage:base coverage:sdk coverage:horizon]

  task all: %i[spec]
end
