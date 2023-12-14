RSpec.describe Stellar::DSL do
  let(:account) { Stellar::Account.from_address("GA5ZSEJYB37JRC5AVCIA5MOP4RHTM335X2KGX3IHOJAPP5RE34K4KZVN") }
  let(:muxed_account) { Stellar::Account.from_address("MA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJVAAAAAAAAAAAAAJLK") }

  specify ".Asset" do
    expect(Asset(nil)).to eq(Stellar::Asset.native)
    expect(Asset("native")).to eq(Stellar::Asset.native)
    expect(Asset("XLM-native")).to eq(Stellar::Asset.native)
    expect(Asset("XLM:native")).to eq(Stellar::Asset.native)
    expect(Asset("USDC-GA5ZSEJYB37JRC5AVCIA5MOP4RHTM335X2KGX3IHOJAPP5RE34K4KZVN")).to eq(Stellar::Asset.alphanum4("USDC", account))
    expect(Asset("USDC:GA5ZSEJYB37JRC5AVCIA5MOP4RHTM335X2KGX3IHOJAPP5RE34K4KZVN")).to eq(Stellar::Asset.alphanum4("USDC", account))
    expect(Asset("USDCDSU-GA5ZSEJYB37JRC5AVCIA5MOP4RHTM335X2KGX3IHOJAPP5RE34K4KZVN")).to eq(Stellar::Asset.alphanum12("USDCDSU", account))
  end

  specify ".Account" do
    expect(Account(nil)).to be_a(Stellar::Account)
    expect(Account(account)).to eq(account)
    expect(Account("GA5ZSEJYB37JRC5AVCIA5MOP4RHTM335X2KGX3IHOJAPP5RE34K4KZVN")).to eq(account)
    expect(Account("MA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJVAAAAAAAAAAAAAJLK")).to eq(muxed_account)
  end
end
