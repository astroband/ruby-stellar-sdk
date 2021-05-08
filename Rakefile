# frozen_string_literal: true

load "tasks/test.rake"
load "tasks/lint.rake"

desc "Run test suites for all gems in this repo"
task test: %i[test:all]
task spec: :test

desc "Run linters for all gems in this repo"
task lint: %i[lint:all]

task default: %i[test lint]

rule(/^(base|sdk):.+$/) do |task|
  gem_dir, task_name = task.name.split(":", 2)
  sh("cd #{gem_dir} && ../bin/rake #{task_name}")
end

desc "Build all gems"
task build: %i[base:build sdk:build]
