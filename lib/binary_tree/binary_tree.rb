class BinaryTree < Node
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left = @right = nil
  end

  def to_s
    "#{val}[#{left}, #{right}]"
  end

  def traverse_pre_order
    sol = [val]
    sol += left.traverse_pre_order if left
    sol += right.traverse_pre_order if right
    sol
  end

  def traverse_in_order
    sol = []
    sol += left.traverse_in_order if left
    sol << val
    sol += right.traverse_in_order if right
    sol
  end

  def traverse_post_order
    sol = []
    sol += left.traverse_post_order if left
    sol += right.traverse_post_order if right
    sol << val
  end
end
