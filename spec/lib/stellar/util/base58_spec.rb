require 'spec_helper'

describe Stellar::Util::Base58 do
  subject{ Stellar::Util::Base58.new(Stellar::Util::Base58::BITCOIN_ALPHABET) }

  describe "#decode" do
    it "properly encodes" do
      expect(decode "z").to eq_bytes("\x39")
      expect(decode "111z").to eq_bytes("\x00\x00\x00\x39")
      expect(decode "2UzHL").to eq_bytes("\xFF\xFF\xFF")
    end

    it "raises an ArgumentError when the string cantains an invalid character" do
      expect{ decode "OOO" }.to raise_error(ArgumentError)
      expect{ decode "\xFF" }.to raise_error(ArgumentError)
      expect{ decode "\x00" }.to raise_error(ArgumentError)
    end

    def decode(bytes)
      subject.decode(bytes)
    end
  end

  describe "#check_decode" do
    it "properly decodes" do
      expect(decode :none, "cKyAv51").to eq_bytes("\x39")
      expect(decode :seed, "RN3BaguaZ6Mi").to eq_bytes("\x00\x00\x00\x39")
      expect(decode :account_id, "1Ahg1iQXoss").to eq_bytes("\xFF\xFF\xFF")
    end

    it "raises an ArgumentError if the decoded version byte does not match the expected value" do
      expect{ decode :none, "1Ahg1iQXoss" }.to raise_error(ArgumentError)
      expect{ decode :seed, "cKyAv51" }.to raise_error(ArgumentError)
      expect{ decode :account_id, "RN3BaguaZ6Mi" }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError if the decoded value cannot be validated by the checksum" do
      expect{decode :seed, "RN3BaguaZ6MM"}.to raise_error(ArgumentError)
    end

    def decode(version, bytes)
      subject.check_decode(version, bytes)
    end
  end

  describe"#encode" do
    it "properly encodes" do
      expect(encode "\x39").to eq("z")
      expect(encode "\x00\x00\x00\x39").to eq("111z")
      expect(encode "\xFF\xFF\xFF").to eq("2UzHL")
    end

    def encode(bytes)
      subject.encode(bytes)
    end
  end

  describe"#check_encode" do
    it "properly encodes" do
      expect(encode :none, "\x39").to eq("cKyAv51")
      expect(encode :seed, "\x00\x00\x00\x39").to eq("RN3BaguaZ6Mi")
      expect(encode :account_id, "\xFF\xFF\xFF").to eq("1Ahg1iQXoss")
    end

    it "raises an ArgumentError when an invalid version is provided" do
      expect{ encode :floob, "\x39" }.to raise_error(ArgumentError)
    end

    def encode(version, bytes)
      subject.check_encode(version, bytes)
    end
  end

end