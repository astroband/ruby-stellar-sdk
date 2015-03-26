namespace :xdr do

  # As Hayashi adds more .x files, we'll need to update this array
  # Prior to launch, we should be separating our .x files into a separate
  # repo, and should be able to improve this integration.
  HAYASHI_XDR = [
    "src/xdr/Stellar-ledger-entries.x",
    "src/xdr/Stellar-ledger.x",
    "src/xdr/Stellar-overlay.x",
    "src/xdr/Stellar-transaction.x",
    "src/xdr/Stellar-types.x",
    "src/overlay/StellarXDR.x",
    "src/scp/SCPXDR.x",
  ]

  task :update => [:download, :generate]

  task :download do
    require 'octokit'
    require 'base64'
    
    client = Octokit::Client.new(:netrc => true)

    HAYASHI_XDR.each do |src|
      local_path = "xdr/" + File.basename(src)
      encoded    = client.contents("stellar/hayashi", path: src).content
      decoded    = Base64.decode64 encoded

      IO.write(local_path, decoded)
    end
  end

  task :generate do
    require "pathname"
    require "xdrgen"
    require 'fileutils'
    FileUtils.rm_rf "generated"

    Pathname.glob("xdr/**/*.x").each do |path|
      $stderr.write "Generating #{path}... "
      compilation = Xdrgen::Compilation.new(path, output_dir:"generated", namespace:"Stellar::XDR")
      compilation.compile
      $stderr.puts "done"
    end
  end
end