# -*- encoding: utf-8 -*-
require File.expand_path('../lib/set/combination/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jared Grippe"]
  gem.email         = ["jared@deadlyicon.com"]
  gem.description   = %q{Defined Set#* and returns a Set::Combination}
  gem.summary       = %q{Defined Set#* and returns a Set::Combination}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "set-combination"
  gem.require_paths = ["lib"]
  gem.version       = Set::Combination::VERSION
end
