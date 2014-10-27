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
    return decapitate(node) if node == head
    n = head
    while n
      bridge(node) if n == node
      n = n.nexxt
    end
  end

  def deduplicate
    existing = Hash.new
    n = head
    while n
      if existing[n.val]
        m = n.nexxt
        remove(n)
        n = m
      else
        existing[n.val] = true
        n = n.nexxt
      end
    end
  end


  def deduplicate_On2
    n = head
    while n
      forward_remove(n.nexxt, n)
      n = n.nexxt
    end
  end

  private

  def decapitate(node)
    @head = node.nexxt
    @head.prev = nil if head
    node.detach.val
  end

  def bridge(node)
    left, right = node.prev, node.nexxt
    right.prev = left if right
    left.nexxt = right
    node.detach.val
  end

  def forward_remove(start, target)
    n = start
    while n
      m = n.nexxt
      bridge(n) if n.val == target.val
      n = m
    end
  end
end
