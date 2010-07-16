class NameFinder
  def initialize(data={})
    @root = data
  end

  def add(term)
    NodeProxy.new(@root).add(normalize(term) + " ", term)
  end

  def find(haystack)
    each_set_of_words(haystack) do |words|
      found = NodeProxy.new(@root).find(words + " ")
      return found if found
    end
    nil
  end

  def export
    @root
  end

private
  def each_set_of_words(haystack)
    words = normalize(haystack).split(/ /)
    (0 ... words.length).each do |i|
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
