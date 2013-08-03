require File.expand_path("../test_helper", __FILE__)
require "name_finder"

describe NameFinder do

  subject { NameFinder.new }

  it "should find an exact match" do
    subject.add "aa bb"
    subject.find("aa bb").must_equal "aa bb"
  end

  it "should be case insensitive and case preserving" do
    subject.add "Aa bb"
    subject.find("AA BB").must_equal "Aa bb"
  end

  it "should find a substring match with text before" do
    subject.add "aa bb"
    subject.find("xx aa bb").must_equal "aa bb"
  end

  it "should find a substring match with text after" do
    subject.add "aa bb"
    subject.find("aa bb xx").must_equal "aa bb"
  end

  it "should find a substring match with text before and after" do
    subject.add "aa bb"
    subject.find("xx aa bb xx").must_equal "aa bb"
  end

  it "should return nil for no match" do
    subject.find("aa").must_be_nil
  end

  it "should not find a substring that does not end on a word boundary" do
    subject.add "aa bb"
    subject.find("aa bbb").must_be_nil
  end

  it "should not find a substring that does not begin on a word boundary" do
    subject.add "aa bb"
    subject.find("aaa bb").must_be_nil
  end

  it "should find longest exact match" do
    subject.add "aa"
    subject.add "aa bb"
    subject.add "aa bbb"
    subject.add "aa bbbb"
    subject.find("xx aa bbb xx").must_equal "aa bbb"
  end

  it "should export and import tree" do
    subject.add "test data"
    export = subject.export
    nf2 = NameFinder.new(export)
    nf2.find("test data").must_equal "test data"
  end
end
