lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mongoid/bitfield/version"

Gem::Specification.new do |spec|
  spec.name          = "mongoid_bitfield"
  spec.version       = Mongoid::Bitfield::VERSION
  spec.authors       = ["Christoph Grabo"]
  spec.email         = ["asaaki@mannaz.cc"]
  spec.description   = "Mongoid::Bitfield stores boolean flags as single property in MongoDB."
  spec.summary       = "Mongoid::Bitfield stores boolean flags as single property."
  spec.homepage      = "http://github.com/asaaki/ryodo"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mongoid", "~> 4.0.0"
  spec.add_dependency "activesupport", ">= 0"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rspec",   "~> 3.1.0"
  spec.add_development_dependency "pry",     "~> 0.10.1"
  spec.add_development_dependency "pry-doc", "~> 0.6.0"
end
