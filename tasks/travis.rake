file "lib/libsodium.so" => :build_libsodium do
  cp $LIBSODIUM_PATH, "lib/libsodium.so"
end

task "ci:sodium" => "lib/libsodium.so"

task :travis => %w(ci:sodium spec)

CLEAN.add "lib/libsodium.*"
