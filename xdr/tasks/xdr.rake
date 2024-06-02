require "tsort"
require "pathname"

Rake.application.options.trace_rules = true
Rake.application.options.trace_output = $stdout

namespace :xdr do
  def xdr_defs(vers = :curr)
    root = Pathname("defs") / vers.to_s
    part_to_file = ->(part) { root / "Stellar-#{part}.x" }
    include_pattern = %r{%\s*#include "xdr/Stellar-([\w-]+).h"}
    TSort.tsort(
      ->(&block) { root.glob("*.x").each(&block) },
      ->(node, &block) { node.read.scan(include_pattern).flatten.map(&part_to_file).each(&block) }
    )
  end

  def concat(out_file, *files)
    File.open(out_file, "w+") do |out|
      files.each do |src|
        yield out, src if block_given?
        IO.copy_stream(src, out)
      end
    end
  end

  file "generated/curr/stellar.x" => xdr_defs(:curr) do |t|
    mkdir_p t.name.pathmap("%d")

    concat t.name, *t.prerequisites do |out, src|
      out.puts "\n// #{src.pathmap("%p")}\n\n"
    end
  end

  file "generated/next/stellar.x" => xdr_defs(:next) do |t|
    mkdir_p t.name.pathmap("%d")

    concat t.name, *t.prerequisites do |out, src|
      out.puts "\n// #{src.pathmap("%p")}\n"
    end
  end

  rule "-generated.rb" => ".x" do |t|
    require "xdrgen"

    workdir = t.name.pathmap("%d")
    namespace = t.name.pathmap("%n")

    compilation = Xdrgen::Compilation.new(
      t.sources,
      output_dir: workdir,
      namespace: namespace,
      language: :ruby
    )

    compilation.compile
  end

  task :clean do
    rm_rf "generated"
  end

  desc "Generate XDR definitions"
  task generate: %w[generated/curr/stellar-generated.rb generated/next/stellar-generated.rb]
end
