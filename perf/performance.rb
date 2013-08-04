lib_path = File.expand_path("../../lib", __FILE__)
$:.unshift lib_path unless $:.include?(lib_path)
require "name_finder"

class NameFinderJob
  SOURCE_PATH = File.expand_path("../sample.txt", __FILE__)

  NAMES = [
    "Mr Bennet",
    "Mrs Bennet",
    "Miss Bingley",
    "Elizabeth",
    "Luther Blissett"
  ]

  EXPECTED = ["Mr Bennet", "Elizabeth", "Mrs Bennet", "Miss Bingley"]

  def run
    source = File.read(SOURCE_PATH)
    nf = NameFinder.new
    NAMES.each do |name|
      nf.add name
    end
    result = nf.find_all_in(source)
    raise "Unexpected output: #{result.inspect}" unless result == EXPECTED
  end
end
