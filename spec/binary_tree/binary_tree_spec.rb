require 'spec_helper'

describe BinaryTree do
  describe 'Search Methods' do
    let(:bt) do
      tim    = BinaryTree.new('Tim')
      phil   = BinaryTree.new('Phil')
      jony   = BinaryTree.new('Jony')
      dan    = BinaryTree.new('Dan')
      katie  = BinaryTree.new('Katie')
      craig  = BinaryTree.new('Craig')
      eddie  = BinaryTree.new('Eddie')
      peter  = BinaryTree.new('Peter')
      andrea = BinaryTree.new('Andrea')

      tim.left, tim.right = jony, phil
      jony.left, jony.right = dan, katie
      katie.left, katie.right = peter, andrea
      phil.left, phil.right = craig, eddie
      tim
    end

    it 'BinaryTree#search_pre_order' do
      bt.traverse_pre_order.must_equal %w[Tim Jony Dan Katie Peter Andrea Phil Craig Eddie]
    end

    it 'BinaryTree#search_in_order' do
      bt.traverse_in_order.must_equal %w[Dan Jony Peter Katie Andrea Tim Craig Phil Eddie]
    end

    it 'BinaryTree#search_post_order' do
      bt.traverse_post_order.must_equal %w[Dan Peter Andrea Katie Jony Craig Eddie Phil Tim]
    end
  end
end
