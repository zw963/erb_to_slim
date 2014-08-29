# -*- encoding: utf-8 -*-

require File.expand_path('../lib/erb_to_slim/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "erb_to_slim"
  s.version = ErbToSlim::VERSION
  s.date = Time.now.strftime('%F')
  s.required_ruby_version = '>= 1.9.1'
  s.authors = ["Billy(zw963)"]
  s.email = ["zw963@163.com"]
  s.summary = "Converts Erb templates to Slim templates"
  s.description = 'Erb to Slim converter'
  s.homepage = "http://github.com/zw963/erb_to_slim"
  s.executables = ["erb_to_slim"]
  s.require_paths = ["lib"]
  s.files = `git ls-files bin lib *.md LICENSE`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f) }

  s.add_development_dependency 'minitest', '~>0'
end
