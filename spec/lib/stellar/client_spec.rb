require "spec_helper"

describe Stellar::Client, ".localhost" do
  subject{ Stellar::Client.localhost }

  it{ should be_a(Stellar::Client) }
end