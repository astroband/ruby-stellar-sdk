require "spec_helper"

describe Stellar::Util::StrKey do
  subject { Stellar::Util::StrKey }

  def decode(version, bytes)
    subject.check_decode(version, bytes)
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

    def encode(version, bytes)
      subject.check_encode(version, bytes)
    end
  end

  describe "#encode_muxed_account" do
    let(:med25519) do
      Stellar::MuxedAccount::Med25519.new(
        id: 0,
        ed25519: decode(:account_id, "GA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJVSGZ")
      )
    end

    let(:muxed_account) { Stellar::MuxedAccount.new(:key_type_muxed_ed25519, med25519) }

    it "properly encodes" do
      strkey = subject.encode_muxed_account(muxed_account.to_xdr)
      expect(strkey).to eq("MAAAAAAAAAAAAAB7BQ2L7E5NBWMXDUCMZSIPOBKRDSBYVLMXGSSKF6YNPIB7Y77ITLVL6")
    end
  end

  describe "#decode_muxed_account" do
    let(:med25519) do
      Stellar::MuxedAccount::Med25519.new(
        id: 0,
        ed25519: decode(:account_id, "GA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJVSGZ")
      )
    end

    it "decodes med25519 properly" do
      expected = Stellar::MuxedAccount.new(:key_type_muxed_ed25519, med25519).to_xdr
      strkey = "MAAAAAAAAAAAAAB7BQ2L7E5NBWMXDUCMZSIPOBKRDSBYVLMXGSSKF6YNPIB7Y77ITLVL6"

      expect(subject.decode_muxed_account(strkey)).to eq(expected)
    end

    it "decodes ed25519 correctly" do
      raw_ed25519 = decode(:account_id, "GA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJVSGZ")
      expected = Stellar::MuxedAccount.new(:key_type_ed25519, raw_ed25519).to_xdr

      strkey = "GA7QYNF7SOWQ3GLR2BGMZEHXAVIRZA4KVWLTJJFC7MGXUA74P7UJVSGZ"

      expect(subject.decode_muxed_account(strkey)).to eq(expected)
    end

    it "raises an error on non-zero unused trailing bit" do
      # unused trailing bit must be zero in the encoding of the last three bytes (24 bits) as five base-32 symbols (25 bits)
      expect {
        subject.decode_muxed_account(
          "MAAAAAAAAAAAAAB7BQ2L7E5NBWMXDUCMZSIPOBKRDSBYVLMXGSSKF6YNPIB7Y77ITLVL7"
        )
      }.to raise_error(ArgumentError, /invalid encoded string/)
    end

    it "raises an error if strkey has an invalid algorithm" do
      # Invalid algorithm (low 3 bits of version byte are 7)
      expect {
        subject.decode_muxed_account(
          "M4AAAAAAAAAAAAB7BQ2L7E5NBWMXDUCMZSIPOBKRDSBYVLMXGSSKF6YNPIB7Y77ITIU2K"
        )
      }.to raise_error(ArgumentError, /Unexpected version/)
    end

    it "raises an error if strkey has an invalid length" do
      expect {
        subject.decode_muxed_account(
          "MCAAAAAAAAAAAAB7BQ2L7E5NBWMXDUCMZSIPOBKRDSBYVLMXGSSKF6YNPIB7Y77ITKNOGA"
        )
      }.to raise_error(ArgumentError, /invalid encoded string/)
    end

    it "raises an error if strkey has padding bytes" do
      expect {
        subject.decode_muxed_account(
          "MAAAAAAAAAAAAAB7BQ2L7E5NBWMXDUCMZSIPOBKRDSBYVLMXGSSKF6YNPIB7Y77ITLVL6==="
        )
      }.to raise_error(ArgumentError, /invalid encoded string/)
    end

    it "raises an error if strkey has an invalid checksum" do
      expect {
        subject.decode_muxed_account(
          "MAAAAAAAAAAAAAB7BQ2L7E5NBWMXDUCMZSIPOBKRDSBYVLMXGSSKF6YNPIB7Y77ITLVL4"
        )
      }.to raise_error(ArgumentError, /Invalid checksum/)
    end
  end
end
