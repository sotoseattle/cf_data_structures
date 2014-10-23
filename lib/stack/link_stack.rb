require_relative '../linked_list/light_linked_list'

class EmptyStackError < RuntimeError; end

class LinkStack < LightLinkedList
  protected :insert, :remove

  def push(datum)
    insert(Node.new(datum))
  end

  def pop
    fail EmptyStackError unless head
    remove(head)
  end
end
