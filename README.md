# Fauthentic

Fauthentic is a gem designed for the sole purpose of making it easy to generate
and handle self-signed SSL certificates in Ruby.

It uses the OpenSSL library, and therefore the primary `generate` method returns
an object containing a cert and key represented as `OpenSSL::X509::Certificate`
and `OpenSSL::PKey::RSA`.

## Thanks

Thanks to @nickyp for posting his original [script for generating a self-signed
certificate](https://gist.github.com/nickyp/886884), from which this library
grew.

## Usage

It's pretty simple:

**Want a Certificate?**

```ruby
ssl = Fauthentic.generate
puts ssl.cert.to_pem
# => -----BEGIN CERTIFICATE----- ...
puts ssl.key.to_s
# => -----BEGIN RSA PRIVATE KEY----- ...
```

**Want to be more specific?**

```ruby
opts = {
  common_name: "my.domain.com", # Default: "example.com"
  country: "BE",                # "US"
  state: "saddened",            # nil
  org: "MyOrg",                 # "Test"
  org_unit: "Test",             # "Test"
  email: "totally-secure-team@my.domain.com", # nil
  expire_in_days: 365           # 30
  serial: 1                     # Current time in billionths of a second + random
}
ssl = Fauthentic.generate(opts)
cert_string = ssl.cert.to_pem
# => "-----BEGIN CERTIFICATE-----..."
key_string = ssl.key.to_s
# => "-----BEGIN RSA PRIVATE KEY----- ..."
```

**Want to read a certificate?**

```ruby
cert = Fauthentic.parse_cert(cert_string)
puts Fauthentic.extract_subject(cert)
# => {C: "US", O: "MyOrg", CN: "my.domain.com", ...}
```

**Want to make sure a key matches a certificate?**
Just use the openssl gem's `check_private_key` method:

```ruby
key = Fauthentic.parse_key(key_string)
cert.check_private_key(key) # => true
```
