require_relative './node'

class LinkedList
  attr_accessor :head, :size

  def initialize
    @head = nil
    @size = 0
    self
  end

  def insert(node)
    self.head, head.next = node, head
    self.size += 1
    self
  end

  def search(value)
    traversor.each do |node|
      return node if node.val == value
    end
    nil
  end

  # private

  def traversor
    return Enumerator.new(size) do |y|
      node = head
      while node
        y.yield(node)
        node = node.next
      end
    end
  end
end
