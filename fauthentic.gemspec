Gem::Specification.new do |s|
  s.name        = 'fauthentic'
  s.version     = '0.0.1'
  s.date        = '2017-06-09'
  s.summary     = "A convenience library for self-signed SSL certificates"
  s.description = "Fauthentic allows you to easily generate, read, parse and verify OpenSSL certificates and keys"
  s.authors     = ["Joe Marty"]
  s.email       = 'josephmarty+fauthentic@gmail.com'
  s.files       = ["lib/fauthentic.rb"]
  s.homepage    = 'http://rubygems.org/gems/fauthentic'
  s.license     = 'MIT'

  s.add_runtime_dependency 'openssl', '~> 2.0'
end
