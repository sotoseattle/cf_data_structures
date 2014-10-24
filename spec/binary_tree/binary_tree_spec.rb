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

    it 'BinaryTree#traverse_pre_order' do
      proc { bt.traverse_pre_order }.must_output "Tim\nJony\nDan\nKatie\nPeter\nAndrea\nPhil\nCraig\nEddie\n"
    end

    it 'BinaryTree#traverse_in_order' do
      proc { bt.traverse_in_order }.must_output "Dan\nJony\nPeter\nKatie\nAndrea\nTim\nCraig\nPhil\nEddie\n"
    end

    it 'BinaryTree#traverse_post_order' do
      proc { bt.traverse_post_order }.must_output "Dan\nPeter\nAndrea\nKatie\nJony\nCraig\nEddie\nPhil\nTim\n"
    end
  end
end
