require 'spec_helper'

describe LinkedList do
  let(:ll_0) { LinkedList.new }
  let(:n1) { Node.new('first') }
  let(:n2) { Node.new('second') }
  let(:n3) { Node.new('third') }
  let(:ll) { ll_0.insert(n1).insert(n2).insert(n3) }

  describe 'LinkedList#size' do
    it { ll_0.size.must_equal 0 }
    it { ll_0.insert(Node.new).size.must_equal 1 }
    it 'after multiple insertions' do
      9.times { ll_0.insert(Node.new) }
      ll_0.size.must_equal 9
    end
  end

  describe 'LinkedList#search' do
    it { ll.search('first').must_equal n1 }
    it { ll.search('second').must_equal n2 }
    it { ll.search('third').must_equal n3 }
    it { ll.search('hola').must_equal nil }
    it { LinkedList.new.search('hola').must_equal nil }
  end

  describe 'LinkedList#remove' do
    it 'remove the tail' do
      ll.remove(n1)
      ll.size.must_equal 2
      ll.to_a.last.must_equal n2
      ll.to_a.last.next.must_equal nil
    end

    it 'remove the middle one' do
      ll.remove(n2)
      ll.size.must_equal 2
      ll.to_a.first.next.must_equal n1
    end

    it 'remove the head' do
      ll.remove(n3)
      ll.size.must_equal 2
      ll.to_a.first.must_equal n2
      ll.to_a.first.next.must_equal n1
    end

    it 'remove 404' do
      n4 = Node.new
      x = ll.remove(n4)
      ll.size.must_equal 3
      x.must_equal nil
    end

    it 'remove from empty list' do
      l = LinkedList.new
      x = l.remove(n1)
      l.size.must_equal 0
      x.must_equal nil
    end

    it 'remove from single-noded list' do
      l = LinkedList.new.insert(n1)
      x = l.remove(n1)
      l.size.must_equal 0
      x.must_equal 'first'
    end
  end

  describe 'LinkedList#to_s' do
    it 'outputs to CSV with jsonified objects' do
      ll.insert(Node.new(42)).insert(Node.new(:item))
      ll.to_s.must_equal "\"item\", 42, \"third\", \"second\", \"first\""
    end
  end
end
