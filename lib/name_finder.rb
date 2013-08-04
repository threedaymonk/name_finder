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
    }
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
        remaining = remaining[found.length .. -1]
      else
        remaining = remaining.sub(/^\S+/, "")
      end
      remaining.lstrip!
    end
  end

  def normalize(term)
    term.downcase.gsub(/\s+/, delimiter).gsub(/[^a-z ]+/, "")
  end

  def delimiter
    " "
  end
end
