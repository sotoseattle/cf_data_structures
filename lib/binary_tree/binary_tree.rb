class BinaryTree
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left = @right = nil
  end

  %w[pre in post].each_with_index do |prefix, index|
    define_method("traverse_#{prefix}_order") do
      do_stuff = -> { puts val }
      left_to_right = side_traversal(prefix).insert(index, do_stuff).each { |x| x.yield }
    end
  end

  private

  def side_traversal(prefix)
    %w[left right].map do |e|
      -> do
        instance_variable_get("@#{e}").public_send("traverse_#{prefix}_order") if instance_variable_get("@#{e}")
      end
    end
  end
end
