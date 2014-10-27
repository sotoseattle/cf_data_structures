require 'spec_helper'

describe DoubleLinkedList do
  let(:dl_0) { DoubleLinkedList.new }
  let(:n1) { DoubleNode.new('first') }
  let(:n2) { DoubleNode.new('second') }
  let(:n3) { DoubleNode.new('third') }
  let(:dl) { dl_0.insert(n1).insert(n2).insert(n3) }

  describe 'DoubleLinkedList#size' do
    it { dl_0.size.must_equal 0 }
    it { dl_0.insert(DoubleNode.new).size.must_equal 1 }
    it 'after multiple insertions' do
      9.times { dl_0.insert(DoubleNode.new) }
      dl_0.size.must_equal 9
    end
  end

  describe 'DoubleLinkedList#search' do
    it { dl.search('first').must_equal n1 }
    it { dl.search('second').must_equal n2 }
    it { dl.search('third').must_equal n3 }
    it { dl.search('hola').must_equal nil }
    it { DoubleLinkedList.new.search('hola').must_equal nil }
  end

  describe 'DoubleLinkedList#remove' do
    it 'remove the tail' do
      dl.remove(n1)
      dl.size.must_equal 2

      dl.head.must_equal n3
      dl.head.nexxt.must_equal n2
      n2.prev.must_equal n3

      n1.nexxt.must_equal nil
      n1.prev.must_equal nil
    end

    it 'remove the middle one' do
      dl.remove(n2)
      dl.size.must_equal 2
      dl.head.must_equal n3
      n3.nexxt.must_equal n1
      n3.prev.must_equal nil

      n1.prev.must_equal n3
      n1.nexxt.must_equal nil

      n2.nexxt.must_equal nil
      n2.prev.must_equal nil
    end

    it 'remove the head' do
      dl.remove(n3)
      dl.size.must_equal 2
      dl.head.must_equal n2
      n2.nexxt.must_equal n1
      n2.prev.must_equal nil

      n1.prev.must_equal n2
      n1.nexxt.must_equal nil

      n3.nexxt.must_equal nil
      n3.prev.must_equal nil
    end

    it 'remove 404' do
      n4 = DoubleNode.new
      x = dl.remove(n4)
      dl.size.must_equal 3
      x.must_equal nil
    end

    it 'remove from empty list' do
      l = DoubleLinkedList.new
      x = l.remove(n1)
      l.size.must_equal 0
      x.must_equal nil
    end

    it 'remove from single-noded list' do
      l = DoubleLinkedList.new.insert(n1)
      x = l.remove(n1)
      l.size.must_equal 0
      x.must_equal 'first'
    end
  end

  describe 'DoubleLinkedList#to_s' do
    it 'outputs to CSV with jsonified objects' do
      dl.insert(DoubleNode.new(42)).insert(DoubleNode.new(:item))
      dl.to_s.must_equal 'item, 42, third, second, first'
    end
  end
end
