# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "column_info_reset/version"

Gem::Specification.new do |s|
  s.name        = "column_info_reset"
  s.version     = ColumnInfoReset::VERSION
  s.authors     = ["Andriy Yanko"]
  s.email       = ["andriy.yanko@gmail.com"]
  s.homepage    = "https://github.com/railsware/column_info_reset"
  s.summary     = %q{Reset ActiveRecord column info when unknown column exception occurs}

  s.rubyforge_project = "column_info_reset"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
