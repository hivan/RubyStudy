# -*- encoding: uft-8 -*-
$:.push File.expand_path(*../lib", _FILE_)
require "NAME/version"


Gem::Specification.new do |s|
  s.name          = "Hivan Du"
  s.version       = NAME::VERSION
  s.authors       = ["Hivan"]
  s.email         = ["doo@hivan.me"]
  s.homepage      = "http://hivan.me"
  s.summary       = %q{TODO: Write a gem summary}
  s.description   = %q{TODO: Write a gem description}

  s.rubyforge_project   = "NAME"

  s.files     = 'git ls-files'.split("\n")
  s.test_files  = 'git ls-files -- {test,spec,features}/*'.split("\n")
  s.executables = 'git ls-files -- bin/*'.split("\n").map{|f| File.basename(f)}
  s.require_paths = ["lib"]
end