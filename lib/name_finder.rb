require "name_finder/version"
require "name_finder/node_proxy"

class NameFinder
  def initialize(tree={})
    @tree = tree
    @root = NodeProxy.new(tree, delimiter)
  end

  attr_reader :root

  def add(term)
    root.add(normalize(term) + delimiter, term)
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
    remaining = normalize(haystack) + delimiter
    while remaining.length > 0
      found = root.find(remaining)
      if found
        yield found
        skip = found.length
      else
        skip = remaining.index(delimiter)
      end
      remaining = remaining[skip + 1 .. -1]
    end
  end

  def normalize(term)
    term.downcase.gsub(/[^a-z]+/, delimiter)
  end

  def delimiter
    " "
  end
end
