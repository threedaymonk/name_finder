require File.expand_path("../performance", __FILE__)
require "benchmark"

job = NameFinderJob.new

Benchmark.benchmark do |b|
  b.report("find_all"){ job.run }
end
