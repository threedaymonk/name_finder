class NameFinder
  class NodeProxy
    def initialize(node, delimiter)
      @node = node
      @delimiter = delimiter
    end

    attr_reader :node, :delimiter

    def add(remainder, term)
      if remainder
        head, tail = split_first(remainder)
        subtree    = node[tokenize(head)] ||= {}
        wrap(subtree).add(tail, term)
      else
        node[0] = term
      end
    end

    def find(remainder, new_word=false)
      if remainder
        head, tail = split_first(remainder)
        if subtree = node[tokenize(head)]
          wrap(subtree).find(tail, head == delimiter)
        elsif new_word
          node[0]
        end
      else
        node[0]
      end
    end

  private
    def split_first(expression)
      expression.scan(/^.|.+/)
    end

    def tokenize(s)
      s[0,1]
    end

    def wrap(node)
      NodeProxy.new(node, delimiter)
    end
  end
end
