class BinaryTree
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left = @right = nil
  end

  %w(pre in post).each_with_index do |prefix, index|
    define_method("traverse_#{prefix}_order") do
      instructions(prefix).insert(index, do_stuff).each(&:yield)
    end
  end

  private

  def do_stuff
    -> { puts val }
  end

  def instructions(prefix)
    [left, right].map { |e| -> { e.send("traverse_#{prefix}_order") if e } }
  end
end
