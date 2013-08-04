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
    each_set_of_words(haystack) do |words|
      found = root.find(words + delimiter)
      return found if found
    end
    nil
  end

  def find_all_in(haystack)
    remaining = haystack + delimiter
    [].tap { |all|
      while remaining.length > 0
        found = root.find(remaining)
        if found
          all << found
          remaining = remaining[found.length .. -1]
        else
          remaining = remaining.sub(/^\S+/, "")
        end
        remaining.lstrip!
      end
    }
  end

  def export
    @tree
  end

private
  def each_set_of_words(haystack)
    words = normalize(haystack).split(/ /)
    words.each_with_index do |_, i|
      yield words[i .. -1].join(delimiter)
    end
  end

  def normalize(term)
    term.downcase.gsub(/\s+/, delimiter).gsub(/[^a-z ]+/, "")
  end

  def delimiter
    " "
  end
end
