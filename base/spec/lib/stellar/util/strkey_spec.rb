require 'spec_helper'

describe Stellar::Util::StrKey do

  subject{ Stellar::Util::StrKey }

  describe "#check_decode" do
    it "properly decodes" do
      expect(decode :seed, "SAAAAAAAAAADST3H").to eq_bytes("\x00\x00\x00\x00\x00\x00\x39")
      expect(decode :account_id, "GD777777777764TU").to eq_bytes("\xFF\xFF\xFF\xFF\xFF\xFF\xFF")
      expect(decode :account_id, "GBQWWBFLRP3BXZD5").to eq_bytes("\x61\x6b\x04\xab\x8b\xf6\x1b")
      expect(decode :pre_auth_tx, "TBU2RRGLXH3E4VON").to eq_bytes("\x69\xa8\xc4\xcb\xb9\xf6\x4e")
      expect(decode :hash_x, "XBU2RRGLXH3E4PNW").to eq_bytes("\x69\xa8\xc4\xcb\xb9\xf6\x4e")
    end

    it "raises an ArgumentError when an invalid version is provided" do
      expect{ decode :floob, "SAAAAAAAAAADST3M" }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError if the decoded version byte does not match the expected value" do
      expect{ decode :seed, "GD777777777764TU" }.to raise_error(ArgumentError)
      expect{ decode :account_id, "SAAAAAAAAAADST3M" }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError if the decoded value cannot be validated by the checksum" do
      expect{ decode :seed, "SAAAAAAAAAADST3M" }.to raise_error(ArgumentError)
    end

    def decode(version, bytes)
      subject.check_decode(version, bytes)
    end
  end

  describe "#check_encode" do
    it "properly encodes" do
      expect(encode :seed, "\x00\x00\x00\x00\x00\x00\x39").to eq("SAAAAAAAAAADST3H")
      expect(encode :account_id, "\xFF\xFF\xFF\xFF\xFF\xFF\xFF").to eq("GD777777777764TU")
      expect(encode :account_id, "\x61\x6b\x04\xab\x8b\xf6\x1b").to eq("GBQWWBFLRP3BXZD5")
      expect(encode :pre_auth_tx, "\x69\xa8\xc4\xcb\xb9\xf6\x4e").to eq_bytes("TBU2RRGLXH3E4VON")
      expect(encode :hash_x, "\x69\xa8\xc4\xcb\xb9\xf6\x4e").to eq_bytes("XBU2RRGLXH3E4PNW")
    end

    it "raises an ArgumentError when an invalid version is provided" do
      expect{ encode :floob, "\x39" }.to raise_error(ArgumentError)
    end

    def encode(version, bytes)
      subject.check_encode(version, bytes)
    end
  end

end


