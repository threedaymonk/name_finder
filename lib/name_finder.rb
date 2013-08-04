require "name_finder/version"
require "name_finder/node_proxy"
require "name_finder/buffer"

class NameFinder
  def initialize(tree={})
    @tree = tree
    @root = NodeProxy.new(tree, delimiter)
  end

  attr_reader :root

  def add(term)
    root.add Buffer.new(normalize(term) + delimiter), term
  end

  def find_in(haystack)
    find(haystack) do |found|
      return found
    end
    nil
  end

  def find_all_in(haystack)
    [].tap { |all|
      find(haystack) do |found|
        all << found
      end
    }.uniq
  end

  def export
    @tree
  end

private
  def find(haystack)
    remaining = Buffer.new(normalize(haystack) + delimiter)
    while !remaining.at_end?
      found = root.find(remaining)
      if found
        yield found
        remaining = remaining.advance_by(found.length)
      else
        remaining = remaining.advance_past(delimiter)
      end
    end
  end

  def normalize(term)
    term.downcase.gsub(/[^a-z]+/, delimiter)
  end

  def delimiter
    " "
  end
end
