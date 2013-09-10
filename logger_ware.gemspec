# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logger_ware/version'

Gem::Specification.new do |spec|
  spec.name          = "logger_ware"
  spec.version       = LoggerWare::VERSION
  spec.authors       = ["Vitaly Kushner"]
  spec.email         = ["vitaly@astrails.com"]
  spec.summary       = "middleware to log rails requests"
  spec.description   = %q{Rails middleware to log requests. Support for parameters and environment filtering. Storage agnostic.}
  spec.homepage      = "http://github.com/astrails/logger_ware"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rack'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'debugger'
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency 'terminal-notifier-guard'
  spec.add_development_dependency 'rb-fchange'
  spec.add_development_dependency 'rb-fsevent'
  spec.add_development_dependency 'rb-inotify'
end
