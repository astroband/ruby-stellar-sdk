RSpec.describe Stellar::AccountFlags do
  describe ".parse_mask" do
    it "parses correctly" do
      expect(described_class.parse_mask(1)).to eq([
        StellarProtocol::AccountFlags.auth_required_flag
      ])
      expect(described_class.parse_mask(2)).to eq([
        StellarProtocol::AccountFlags.auth_revocable_flag
      ])
      expect(described_class.parse_mask(3)).to eq([
        StellarProtocol::AccountFlags.auth_required_flag,
        StellarProtocol::AccountFlags.auth_revocable_flag
      ])
    end
  end

  describe ".make_mask" do
    it "makes correctly" do
      expect(described_class.make_mask([StellarProtocol::AccountFlags.auth_required_flag])).to eq(1)
      expect(described_class.make_mask([StellarProtocol::AccountFlags.auth_revocable_flag])).to eq(2)
      expect(described_class.make_mask([
        StellarProtocol::AccountFlags.auth_required_flag,
        StellarProtocol::AccountFlags.auth_revocable_flag
      ])).to eq(3)
    end
  end
end
