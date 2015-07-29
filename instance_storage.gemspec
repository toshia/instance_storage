# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'instance_storage/version'

Gem::Specification.new do |spec|
  spec.name          = "instance_storage"
  spec.version       = InstanceStorage::VERSION
  spec.authors       = ["Toshiaki Asai"]
  spec.email         = ["toshi.alternative@gmail.com"]
  spec.summary       = %q{Manage class instances with dictionary}
  spec.description   = %q{Manage class instances with dictionary.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
