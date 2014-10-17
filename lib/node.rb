class Node
  attr_accessor :val, :next

  def initialize(val = nil)
    @next = nil
    @val = val
  end

  def detach
    @next = nil
    @val
  end
end
