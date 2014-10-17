class Node
  attr_accessor :val, :next

  def initialize(val = nil)
    @next = nil
    @val = val
  end
end
