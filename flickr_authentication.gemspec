# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flickr_authentication/version'

Gem::Specification.new do |spec|
  spec.name          = "flickr_authentication"
  spec.version       = FlickrAuthentication::VERSION
  spec.authors       = ["Stephen Schor"]
  spec.email         = ["beholdthepanda@gmail.com"]
  spec.description   = %q{A library that simplifies the authentication and storing of credentials for applicartions that use the Flickr API}
  spec.summary       = %q{A library that simplifies the authentication and storing of credentials for applicartions that use the Flickr API}
  spec.homepage      = "https://github.com/nodanaonlyzuul/flickr_authentication"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency('launchy',  '0.4.0')
  spec.add_dependency('flickraw', '0.9.8')

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end
