class Node
  attr_accessor :val, :nexxt

  def initialize(val = nil)
    @val = val
  end

  def to_s
    val.to_s
  end
end

class LightLinkedList
  attr_accessor :head

  def initialize(node = nil)
    @head = node
    self
  end

  def insert(node)
    existing_node = head
    node.nexxt = existing_node
    @head = node
    self
  end

  def search(value)
    n = head
    while n
      return n if n.val == value
      n = n.nexxt
    end
  end

  def to_s
    str = []
    n = head
    while n
      str << n.val.to_s
      n = n.nexxt
    end
    str.join(', ')
  end

  def remove(node)
    prev = nil
    n = head
    while n
      if n == node
        prev ? prev.nexxt = node.nexxt : @head = head.nexxt
        node.nexxt = nil
        return node.val
      end
      prev = n
      n = n.nexxt
    end
  end

  def size
    i = 0
    n = head
    while n
      i += 1
      n = n.nexxt
    end
    i
  end
end
