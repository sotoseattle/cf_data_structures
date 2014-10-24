class BinaryTree < Node
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left = @right = nil
  end

  def traverse_pre_order
    puts val
    left.traverse_pre_order if left
    right.traverse_pre_order if right
  end

  def traverse_in_order
    left.traverse_in_order if left
    puts val
    right.traverse_in_order if right
  end

  def traverse_post_order
    left.traverse_post_order if left
    right.traverse_post_order if right
    puts val
  end
end
