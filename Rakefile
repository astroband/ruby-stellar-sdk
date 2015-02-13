require "bundler/gem_tasks"
Bundler.setup

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
rescue LoadError
end

task :update do
  require "pathname"
  require "xdrgen"
  #  TODO: download XDR
  Pathname.glob("xdr/**/*.x").each do |path|
    $stderr.puts "Generating #{path}"
    compilation = Xdrgen::Compilation.new(path, "generated")
    compilation.compile
  end
end


