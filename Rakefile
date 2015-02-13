require "bundler/gem_tasks"
Bundler.setup

require "pathname"
require "xdrgen"

task :update do
  #  TODO: download XDR
  Pathname.glob("xdr/**/*.x").each do |path|
    $stderr.puts "Generating #{path}"
    compilation = Xdrgen::Compilation.new(path, "generated")
    compilation.compile
  end
end