require 'spec_helper'

describe LinkedList do
  let(:ll_0) { LinkedList.new }

  describe 'LinkedList#size' do
    it { ll_0.size.must_equal 0 }
    it { ll_0.insert(Node.new).size.must_equal 1 }
    it 'after multiple insertions' do
      9.times { ll_0.insert(Node.new) }
      ll_0.size.must_equal 9
    end
  end

  describe 'LinkedList#search' do
    let(:n1) { Node.new('first') }
    let(:n2) { Node.new('second') }
    let(:n3) { Node.new('third') }
    let(:ll) { ll_0.insert(n1).insert(n2).insert(n3) }

    it { ll.search('first').must_equal n1 }
    it { ll.search('second').must_equal n2 }
    it { ll.search('third').must_equal n3 }
    it { ll.search('hola').must_equal nil }
    it { LinkedList.new.search('hola').must_equal nil }
  end

  describe 'LinkedList#remove' do
    # given a LL with n nodes
    # when I remove a node
    # the node is deleted from the list
    # and the val is returned
    # or nil if not found
  end

  describe 'LinkedList#to_s' do
    # given a LL with n nodes
    # when I tranform it into a string
    # then a string is returned in CSV format
  end
end
