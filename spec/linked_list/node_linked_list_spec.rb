require 'spec_helper'

describe NodeLinkedList do
  let(:a) { NodeLinkedList.new('A') }
  let(:b) { NodeLinkedList.new('B') }
  let(:c) { NodeLinkedList.new('C') }
  let(:n) { a.insert(b).insert(c) }

  describe 'insert' do
    it 'add to single node' do
      a.insert(b)
      b.nexxt.must_equal a
      a.nexxt.must_equal nil
    end

    it 'add to linked node' do
      a.insert(b).insert(c)
      c.nexxt.must_equal b
      b.nexxt.must_equal a
    end
  end

  describe 'size' do
    it { a.size.must_equal 1 }

    it 'size as count' do
      n
      c.size.must_equal 3
      b.size.must_equal 2
      a.size.must_equal 1
    end
  end

  describe 'LinkedList#search' do
    it { n.search('A').must_equal a }
    it { n.search('B').must_equal b }
    it { n.search('C').must_equal c }
    it { n.search('hola').must_equal nil }
  end

  describe 'LinkedList#remove' do
    it 'remove the tail' do
      n.remove(a)
      n.size.must_equal 2
      c.nexxt.must_equal b
      b.nexxt.must_equal nil
    end

    it 'remove the middle one' do
      n.remove(b)
      n.size.must_equal 2
      c.nexxt.must_equal a
      a.nexxt.must_equal nil
    end

    it 'remove the head' do
      n.remove(c)
      b.size.must_equal 2
      b.nexxt.must_equal a
      a.nexxt.must_equal nil
    end

    it 'remove 404' do
      d = NodeLinkedList.new('yada')
      x = n.remove(d)
      n.size.must_equal 3
      x.must_equal nil
    end

    it 'remove from self (single-noded list)' do
      a.remove(a).must_equal a
    end
  end

  describe 'LinkedList#to_s' do
    it 'outputs to CSV with jsonified objects' do
      n.to_s.must_equal 'C, B, A'
    end
  end
end
