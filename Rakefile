require "rake/testtask"
require "open-uri"

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.ruby_opts << "-w"
  t.verbose = true
end

file "perf/sample.txt" do |t|
  open "http://www.gutenberg.org/cache/epub/1342/pg1342.txt" do |src|
    open t.name, "w" do |dest|
      dest << src.read
    end
  end
end

desc "Run benchmark"
task :benchmark => "perf/sample.txt" do |t|
  system "ruby -v"
  system "ruby perf/benchmark.rb"
end
