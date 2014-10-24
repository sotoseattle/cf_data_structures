class BinaryTree
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left = @right = nil
  end

  %w[pre in post].each_with_index do |prefix, index|
    define_method("traverse_#{prefix}_order") do
      left_to_right = [
        -> { left.public_send("traverse_#{prefix}_order") if left },
        -> { right.public_send("traverse_#{prefix}_order") if right }]
      do_stuff = -> { puts val }
      left_to_right.insert(index, do_stuff)
      left_to_right.each { |x| x.yield }
    end
  end
end
