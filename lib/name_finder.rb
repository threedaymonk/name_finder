require "name_finder/version"

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

  class NodeProxy
    def initialize(node)
      @node = node
    end

    def add(remainder, term)
      if remainder
        head, tail = split_first(remainder)
        subtree    = @node[tokenize(head)] ||= {}
        wrap(subtree).add(tail, term)
      else
        @node[0] = term
      end
    end

    def find(remainder, new_word=false)
      if remainder
        head, tail = split_first(remainder)
        if subtree = @node[tokenize(head)]
          wrap(subtree).find(tail, head == " ")
        elsif new_word
          @node[0]
        end
      else
        @node[0]
      end
    end

  private
    def split_first(expression)
      expression.scan(/^.|.+/)
    end

    def tokenize(s)
      s.unpack('U').first
    end

    def wrap(node)
      NodeProxy.new(node)
    end
  end
end
