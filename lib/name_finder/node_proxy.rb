class NameFinder
  class NodeProxy
    def initialize(node, delimiter)
      @node = node
      @delimiter = delimiter
    end

    attr_reader :node, :delimiter

    def add(buffer, term)
      if buffer.at_end?
        node[0] = term
      else
        subtree = node[buffer.head] ||= {}
        wrap(subtree).add buffer.rest, term
      end
    end

    def find(buffer, new_word=false)
      if buffer.at_end?
        node[0]
      else
        head = buffer.head
        if subtree = node[head]
          wrap(subtree).find(buffer.rest, head == delimiter)
        elsif new_word
          node[0]
        end
      end
    end

  private
    def wrap(node)
      NodeProxy.new(node, delimiter)
    end
  end
end
