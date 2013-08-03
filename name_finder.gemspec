lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)

require "name_finder/version"

spec = Gem::Specification.new do |s|
  s.name             = "name_finder"
  s.version          = NameFinder::VERSION
  s.author           = "Paul Battley"
  s.email            = "pbattley@gmail.com"
  s.summary          = "Find matching names in text"
  s.files            = Dir["{lib,test}/**/*.rb"]
  s.require_path     = "lib"
  s.test_files       = Dir["test/*_test.rb"]
  s.has_rdoc         = true
  s.extra_rdoc_files = %w[COPYING.txt]
  s.homepage         = "https://github.com/threedaymonk/name_finder"
  s.add_development_dependency "rake"
end