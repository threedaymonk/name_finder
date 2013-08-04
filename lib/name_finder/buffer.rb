class NameFinder
  class Buffer
    def initialize(string, position = 0)
      @string = string
      @position = position
      @length = string.length
    end

    def advance_by(n)
      new(@position + n)
    end

    def advance_past(delimiter)
      p = (@position ... @length).find { |i| @string[i] == delimiter }
      if p
        new(p + 1)
      else
        new(@length)
      end
    end

    def at_end?
      @position >= @length
    end

    def head
      @string[@position, 1]
    end

    def rest
      new(@position + 1)
    end

    def inspect(*args)
      "<Buffer:#{@string[@position .. -1].inspect}>"
    end

  private
    def new(position)
      Buffer.new(@string, position)
    end
  end
end
