lib_path = File.expand_path("../../lib", __FILE__)
$:.unshift lib_path unless $:.include?(lib_path)
require "test/unit"
require "name_finder"

class NameFinderTest < Test::Unit::TestCase

  def setup
    @nf = NameFinder.new
  end
  attr_reader :nf

  def test_should_find_an_exact_match
    nf.add "aa bb"
    assert_equal "aa bb", nf.find("aa bb")
  end

  def test_should_be_case_insensitive_and_case_preserving
    nf.add "Aa bb"
    assert_equal "Aa bb", nf.find("AA BB")
  end

  def test_should_find_a_substring_match_with_text_before
    nf.add "aa bb"
    assert_equal "aa bb", nf.find("xx aa bb")
  end

  def test_should_find_a_substring_match_with_text_after
    nf.add "aa bb"
    assert_equal "aa bb", nf.find("aa bb")
  end

  def test_should_find_a_substring_match_with_text_before_and_after
    nf.add "aa bb"
    assert_equal "aa bb", nf.find("xx aa bb xx")
  end

  def test_should_return_nil_for_no_match
    assert_nil nf.find("aa")
  end

  def test_should_not_find_a_substring_that_does_not_end_on_a_word_boundary
    nf.add "aa bb"
    assert_nil nf.find("aa bbb")
  end

  def test_should_not_find_a_substring_that_does_not_begin_on_a_word_boundary
    nf.add "aa bb"
    assert_nil nf.find("aaa bb")
  end

  def test_should_find_longest_exact_match
    nf.add "aa"
    nf.add "aa bb"
    nf.add "aa bbb"
    nf.add "aa bbbb"
    assert_equal "aa bbb", nf.find("xx aa bbb xx")
  end

  def test_should_export_and_import_tree
    nf.add "test data"
    export = nf.export
    nf2 = NameFinder.new(export)
    assert_equal "test data", nf2.find("test data")
  end
end

