# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webern/version'

Gem::Specification.new do |spec|
  spec.name          = "webern"
  spec.version       = Webern::VERSION
  spec.authors       = ["Michael Berkowitz"]
  spec.email         = ["michael.berkowitz@gmail.com"]
  spec.description   = %q{Transforms user input into a complete 12-tone row and computes all 48 (at most) possible rows that result from the matrix of that row.}
  spec.summary       = %q{Calculates all 48 possible 12-tone rows from the given input}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'prawn'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "terminal-notifier-guard"
  spec.add_development_dependency "rb-fsevent"
end
