require "name_finder/version"
require "name_finder/node_proxy"

class NameFinder
  def initialize(data={})
    @data = data
    @root = NodeProxy.new(@data)
  end

  def add(term)
    @root.add(normalize(term) + " ", term)
  end

  def find_in(haystack)
    each_set_of_words(haystack) do |words|
      found = @root.find(words + " ")
      return found if found
    end
    nil
  end

  def find_all_in(haystack)
    remaining = haystack + " "
    [].tap { |all|
      while remaining.length > 0
        found = @root.find(remaining)
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
    @data
  end

private
  def each_set_of_words(haystack)
    words = normalize(haystack).split(/ /)
    words.each_with_index do |_, i|
      yield words[i .. -1].join(" ")
    end
  end

  def normalize(term)
    term.downcase.gsub(/\s+/, " ").gsub(/[^a-z ]+/, "")
  end
end
