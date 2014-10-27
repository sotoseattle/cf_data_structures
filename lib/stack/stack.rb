require_relative '../linked_list/light_linked_list'

class Stack < LightLinkedList
  protected :insert, :remove

  def push(datum)
    insert(Node.new(datum))
  end

  def pop
    fail RuntimeError.new('EmptyStackError') unless head
    remove(head)
  end
end
