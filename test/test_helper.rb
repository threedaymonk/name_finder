lib_path = File.expand_path("../../lib", __FILE__)
$:.unshift lib_path unless $:.include?(lib_path)
require "minitest/spec"
require "minitest/autorun"
