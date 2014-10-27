NodeLinkedList = Struct.new(:val) do
  attr_accessor :nexxt

  def initialize(*)
    @nexxt = nil
    super
  end

  def insert(node)
    node.nexxt = self
    node  # allows chaining
  end

  def search(val)
    walk { |n| return n if n.val == val }
    nil
  end

  def size
    i = 0
    walk { i += 1 }
    i
  end

  def remove(node)
    prev = nil
    walk do |n|
      if n == node
        prev ? prev.nexxt = n.nexxt : n.nexxt = nil
        return n
      end
      prev = n
    end
    nil
  end

  def to_s
    arr = []
    walk { |n| arr << n.val }
    arr.join(', ')
  end

  private

  def walk(&_block)
    n = self
    while n
      yield(n)
      n = n.nexxt
    end
  end
end
