# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'turnip/parallel_tests/version'

Gem::Specification.new do |spec|
  spec.name          = "turnip-parallel_tests"
  spec.version       = Turnip::ParallelTests::VERSION
  spec.authors       = ["Wataru MIYAGUNI"]
  spec.email         = ["gonngo@gmail.com"]
  spec.description   = %q{Helper ParallelTests for Turnip}
  spec.summary       = %q{Helper ParallelTests for Turnip}
  spec.homepage      = "https://github.com/gongo/turnip-parallel_tests"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'parallel_tests'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
