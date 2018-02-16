namespace :xdr do

  # As Hayashi adds more .x files, we'll need to update this array
  # Prior to launch, we should be separating our .x files into a separate
  # repo, and should be able to improve this integration.
  HAYASHI_XDR = [
                 "src/xdr/Stellar-types.x",
                 "src/xdr/Stellar-ledger-entries.x",
                 "src/xdr/Stellar-transaction.x",
                 "src/xdr/Stellar-ledger.x",
                 "src/xdr/Stellar-overlay.x",
                 "src/xdr/Stellar-SCP.x",
                ]

  LOCAL_XDR_PATHS = HAYASHI_XDR.map{ |src| "xdr/" + File.basename(src) }

  task :update => [:download, :generate]

  task :download do
    require 'octokit'
    require 'base64'
    FileUtils.rm_rf "xdr/"
    FileUtils.mkdir_p "xdr"

    client = Octokit::Client.new(:netrc => true)

    HAYASHI_XDR.each do |src|
      local_path = "xdr/" + File.basename(src)
      encoded    = client.contents("stellar/stellar-core", path: src, ref: "prod").content
      decoded    = Base64.decode64 encoded

      IO.write(local_path, decoded)
    end
  end

  task :generate do
    require "pathname"
    require "xdrgen"
    require 'fileutils'
    FileUtils.rm_rf "generated"

    compilation = Xdrgen::Compilation.new(
      LOCAL_XDR_PATHS,
      output_dir: "generated",
      namespace:  "stellar-base-generated",
      language:   :ruby
    )
    compilation.compile
  end
end
