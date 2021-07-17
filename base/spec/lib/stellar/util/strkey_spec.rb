RSpec.describe Stellar::Util::StrKey do
  subject { Stellar::Util::StrKey }

  def encode(version, bytes)
    described_class.check_encode(version, bytes)
  end

  def decode(version, bytes)
    described_class.check_decode(version, bytes)
  end

  describe "#check_decode" do
    it "properly decodes" do
      expect(decode(:seed, "SAAAAAAAAAADST3H")).to eq_bytes("\x00\x00\x00\x00\x00\x00\x39")
      expect(decode(:account_id, "GD777777777764TU")).to eq_bytes("\xFF\xFF\xFF\xFF\xFF\xFF\xFF")
      expect(decode(:account_id, "GBQWWBFLRP3BXZD5")).to eq_bytes("\x61\x6b\x04\xab\x8b\xf6\x1b")
      expect(decode(:pre_auth_tx, "TBU2RRGLXH3E4VON")).to eq_bytes("\x69\xa8\xc4\xcb\xb9\xf6\x4e")
      expect(decode(:hash_x, "XBU2RRGLXH3E4PNW")).to eq_bytes("\x69\xa8\xc4\xcb\xb9\xf6\x4e")
    end

    it "raises an ArgumentError when an invalid version is provided" do
      expect { decode :floob, "SAAAAAAAAAADST3M" }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError if the decoded version byte does not match the expected value" do
      expect { decode :seed, "GD777777777764TU" }.to raise_error(ArgumentError)
      expect { decode :account_id, "SAAAAAAAAAADST3M" }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError if the decoded value cannot be validated by the checksum" do
      expect { decode :seed, "SAAAAAAAAAADST3M" }.to raise_error(ArgumentError)
    end
  end

  describe "#check_encode" do
    it "properly encodes" do
      expect(encode(:seed, "\x00\x00\x00\x00\x00\x00\x39")).to eq("SAAAAAAAAAADST3H")
      expect(encode(:account_id, "\xFF\xFF\xFF\xFF\xFF\xFF\xFF")).to eq("GD777777777764TU")
      expect(encode(:account_id, "\x61\x6b\x04\xab\x8b\xf6\x1b")).to eq("GBQWWBFLRP3BXZD5")
      expect(encode(:pre_auth_tx, "\x69\xa8\xc4\xcb\xb9\xf6\x4e")).to eq_bytes("TBU2RRGLXH3E4VON")
      expect(encode(:hash_x, "\x69\xa8\xc4\xcb\xb9\xf6\x4e")).to eq_bytes("XBU2RRGLXH3E4PNW")
    end

    it "raises an ArgumentError when an invalid version is provided" do
      expect { encode :floob, "\x39" }.to raise_error(ArgumentError)
    end
  end

  describe "#encode_muxed_account" do
    let(:ed25519) do
      decode(:account_id, "GA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJVSGZ")
    end

    context "when ed25519 account is given" do
      let(:muxed_account) { Stellar::MuxedAccount.ed25519(ed25519) }

      it "encodes muxed account as G... address" do
        strkey = subject.encode_muxed_account(muxed_account)
        expect(strkey).to eq("GA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJVSGZ")
      end
    end

    context "when med25519 account is given" do
      let(:muxed_account) { Stellar::MuxedAccount.med25519(ed25519: ed25519, id: 0) }

      it "encodes muxed account as M... address" do
        strkey = subject.encode_muxed_account(muxed_account)
        expect(strkey).to eq("MA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJUAAAAAAAAAAAACJUQ")
      end
    end
  end

  describe "#decode_muxed_account" do
    let(:address) { "GA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJVSGZ" }
    let(:raw_key) { decode(:account_id, address) }

    subject(:decoded) { described_class.decode_muxed_account(strkey) }

    context "with M... address" do
      let(:strkey) { "MA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJUAAAAAAAAAAAACJUQ" }

      it { is_expected.to be_a(Stellar::MuxedAccount) }
      its(:arm) { is_expected.to eq(:med25519) }
      its("med25519.ed25519") { is_expected.to eq(raw_key) }
      its("med25519.id") { is_expected.to eq(0) }
    end

    context "with G... address" do
      let(:strkey) { "GA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJVSGZ" }

      it { is_expected.to be_a(Stellar::MuxedAccount) }
      its(:arm) { is_expected.to eq(:ed25519) }
      its(:ed25519) { is_expected.to eq(raw_key) }
    end
  end
end
