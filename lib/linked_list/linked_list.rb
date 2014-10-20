class Node
  attr_reader :val, :nexxt

  def initialize(val = nil)
    @nexxt = nil
    @val = val
  end

  def point_to(other)
    @nexxt = other
  end

  def detach
    @nexxt = nil
    val
  end


  def to_s
    val.to_s
  end

  private

  attr_writer :val, :nexxt
end

class LinkedList
  private

  attr_accessor :head

  public

  attr_reader :traversor

  def initialize
    @head = nil
    @traversor = Enumerator.new do |y|
      node = head
      while node
        y << node
        node = node.nexxt
      end
    end
    self
  end

  def size
    traversor.count
  end

  def insert(node)
    temp = head
    self.head = node
    node.point_to(temp)
    self
  end

  def search(value)
    traversor.each { |node| return node if node.val == value }
    nil
  end

  def remove(node)
    prev = nil
    traversor.each do |n|
      if n == node
        prev ? prev.point_to(node.nexxt) : @head = node.nexxt
        return node.detach
      end
      prev = n
    end
    nil
  end

  def to_s
    traversor.map(&:to_s).join(', ')
  end

  def to_a
    traversor.to_a
  end
end
