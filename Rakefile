# frozen_string_literal: true

load "tasks/test.rake"
load "tasks/lint.rake"

desc "Run test suites for all gems in this repo"
task test: %i[test:all]
task spec: :test

desc "Run linters for all gems in this repo"
task lint: %i[lint:all]

task default: %i[test lint]
