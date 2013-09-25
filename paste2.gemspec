# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paste2/version'

Gem::Specification.new do |spec|
  spec.name          = "paste2"
  spec.version       = Paste2::VERSION
  spec.authors       = ["Evgeniy Shurmin "]
  spec.email         = ["eshurmin@gmail.com"]
  spec.description   = %q{Utility allow create posts on Paste2.org}
  spec.summary       = %q{Utility allow create posts on Paste2.org}
  spec.homepage      = "http://github.com/jpascal/paste2"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
