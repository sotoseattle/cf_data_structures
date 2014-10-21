require_relative '../linked_list/light_linked_list'

class LinkQueue < LightLinkedList
  protected :insert, :remove

  def enqueue(val)
    insert(Node.new(val))
  end

  def dequeue
    fail 'EmptyStackError' unless head
    n = head
    n = n.nexxt while n.nexxt
    remove n
  end
end
