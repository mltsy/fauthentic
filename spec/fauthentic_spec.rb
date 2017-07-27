require 'fauthentic'
require 'openssl'

describe Fauthentic do
  describe "::generate" do
    context "with no arguments" do
      it "generates a valid certificate and key pair" do
        ssl = Fauthentic.generate
        expect(ssl.cert.class).to eq(OpenSSL::X509::Certificate)
        expect(ssl.cert.check_private_key(ssl.key)).to be(true)
      end

      it "generates a new serial number" do
        prior_serial = Fauthentic.generate_serial
        ssl = Fauthentic.generate
        expect(ssl.cert.serial.to_i).to be > prior_serial
      end
    end

    context "with all the arguments" do
      let(:cert_options) do
        {
          country: 'BE',
          state: 'Minnesota',
          org: 'MyOrg',
          org_unit: 'MyUnit',
          common_name: 'my.domain.com',
          email: 'my@email.com',
          expire_in_days: 42,
          serial: 1
        }
      end

      it "generates a certificate with the right parameters" do
        ssl = Fauthentic.generate(cert_options)
        subject = Fauthentic.extract_subject(ssl.cert)
        expect(subject).to(include(
          C: 'BE',
          ST: 'Minnesota',
          O: 'MyOrg',
          OU: 'MyUnit',
          CN: 'my.domain.com',
          emailAddress: 'my@email.com'
        ))
        expect(ssl.cert.not_after).to be <= Time.now + 42 * 24 * 60 * 60
        expect(ssl.cert.serial.to_i).to be 1
      end
    end
  end

  describe "::parse_cert" do
    it "can parse a valid certificates" do
      ssl = Fauthentic.generate
      cert = Fauthentic.parse_cert(ssl.cert.to_pem)
      expect(cert.class).to be(OpenSSL::X509::Certificate)
      expect(cert.check_private_key(ssl.key)).to be(true)
    end
  end

  describe "::parse_key" do
    it "can parse a valid key" do
      ssl = Fauthentic.generate
      key = Fauthentic.parse_key(ssl.key.to_s)
      expect(key.class).to be(OpenSSL::PKey::RSA)
      expect(ssl.cert.check_private_key(key)).to be(true)
    end
  end
end
