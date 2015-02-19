require "bundler/gem_tasks"
Bundler.setup

require "rbnacl/rake_tasks"

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

# libsodium support for travis

file "lib/libsodium.so" => :build_libsodium do
  cp $LIBSODIUM_PATH, "lib/libsodium.so"
end

task "ci:sodium" => "lib/libsodium.so"

task :travis => %w(ci:sodium spec)

CLEAN.add "lib/libsodium.*"

# end libsodium tasks