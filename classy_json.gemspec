# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'classy_json/version'

Gem::Specification.new do |spec|
  spec.name          = "classy_json"
  spec.version       = ClassyJson::VERSION
  spec.authors       = ["Anthony Ross"]
  spec.email         = ["anthony.ross@validic.com"]
  spec.summary       = %q{ClassyJSON is a simple JSON parsing library that objectifies JSON into classes.}
  spec.description   = %q{The use case is for ClassyJSON is to allow ruby-like access to JSON rather than using the default Hash interface you get when you typically parse JSON}
  spec.homepage      = "https://github.com/allcentury/classy_json"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "pry", "~> 0.10.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'activesupport'
end
