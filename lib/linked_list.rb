require_relative './node'

class LinkedList
  attr_accessor :head
  attr_reader :traversor

  def initialize
    @head = nil
    @traversor = Enumerator.new do |y|
      node = head
      while node
        y.yield(node)
        node = node.next
      end
    end
    self
  end

  def size
    traversor.count
  end

  def insert(node)
    self.head, node.next = node, head
    self
  end

  def search(value)
    traversor.each { |node| return node if node.val == value }
    nil
  end

  def remove(node)
    if first == node
      self.head = node.next
      return node.detach
    end

    traversor.each do |n|
      if n.next == node
        n.next = node.next
        return node.detach
      end
    end
    nil
  end


  def last
    traversor.to_a.last
  end

  def first
    traversor.to_a.first
  end

end
