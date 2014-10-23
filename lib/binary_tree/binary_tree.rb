class BinaryTree < Node
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left = @right = nil
  end

  def traverse_pre_order
    path = [val]
    path += left.traverse_pre_order if left
    path += right.traverse_pre_order if right
    path
  end

  def traverse_in_order
    path = []
    path += left.traverse_in_order if left
    path << val
    path += right.traverse_in_order if right
    path
  end

  def traverse_post_order
    path = []
    path += left.traverse_post_order if left
    path += right.traverse_post_order if right
    path << val
  end
end
