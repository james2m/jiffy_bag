# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jiffy_bag/version'

Gem::Specification.new do |spec|
  spec.name          = "jiffy_bag"
  spec.version       = JiffyBag::VERSION
  spec.authors       = ["James McCarthy"]
  spec.email         = ["james2mccarthy@gmail.com"]

  spec.summary       = %q{Package up Ruby objects into neat little packages for sending between services.}
  spec.description   = %q{Takes an object zips it up into a serialized, zipped, Base64 encoded string to send between services.}
  spec.homepage      = 'http://github.com/james2m/jiffy_bag'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
