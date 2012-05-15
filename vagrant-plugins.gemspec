# -*- encoding: utf-8 -*-
require File.expand_path('../lib/vagrant-plugins/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Robert Schulze"]
  gem.email         = ["robert@dotless.de"]
  gem.description   = %q{vagrant-plugins is a vagrant plugin to list all vagrant plugins loaded in the current vagrant environment}
  gem.summary       = %q{vagrant-plugins lists active vagrant plugins}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "vagrant-plugins"
  gem.require_paths = ["lib"]
  gem.version       = VagrantPlugininspection::VERSION

  gem.add_dependency "vagrant", ">= 1.1.0.dev"
end
