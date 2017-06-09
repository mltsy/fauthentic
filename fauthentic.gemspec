# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fauthentic/version'

Gem::Specification.new do |spec|
  spec.name          = "fauthentic"
  spec.version       = Fauthentic::VERSION
  spec.authors       = ["Joe Marty"]
  spec.email         = ["jmarty@iexposure.com"]

  spec.summary       = "A convenience library for self-signed SSL certificates"
  spec.description   = "Fauthentic allows you to easily generate, read, parse and verify OpenSSL certificates and keys"
  spec.homepage      = "https://github.com/mltsy/fauthentic"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"

  spec.add_runtime_dependency 'openssl', '~> 2.0'
end
