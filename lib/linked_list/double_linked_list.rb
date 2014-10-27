class DoubleNode < Node
  attr_accessor :prev

  def detach
    @nexxt = nil
    @prev = nil
    self
  end
end

class DoubleLinkedList < LightLinkedList
  def insert(node)
    if @head
      head.prev = node
      node.nexxt = head
      node.prev = nil
    end
    @head = node
    self
  end

  def remove(node)
    if node == @head
      @head = node.nexxt
      @head.prev = nil if @head
      return node.detach.val
    end
    n = @head
    while n
      if n == node
        n.nexxt.prev = n.prev if n.nexxt
        n.prev.nexxt = n.nexxt
        return node.detach.val
      end
      n = n.nexxt
    end
  end
end
