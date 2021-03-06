require 'spec_helper'

describe LinkStack do
  let(:empty_s) { LinkStack.new }
  let(:s) do
    s = LinkStack.new
    s.push(23)
    s.push('24')
    s.push(0)
    s
  end

  describe 'LinkStackLinked#push' do
    it 'inserts in an empty stack' do
      empty_s.push(23)
      empty_s.size.must_equal 1
      empty_s.to_s.must_equal '23'
    end

    it 'inserts in a populated stack at the top' do
      s.size.must_equal 3
      s.to_s.must_equal '0, 24, 23'
    end
  end

  describe 'LinkStackLinked#pop' do
    it 'returns the element data' do
      s.pop.must_equal 0
    end

    it 'removes the element' do
      s.pop
      s.size.must_equal 2
      s.to_s.must_equal '24, 23'
      s.search(0).must_equal nil
    end

    it 'removes the elements' do
      s.pop
      s.pop
      s.size.must_equal 1
      s.to_s.must_equal '23'
    end

    it 'throws exception if stack is already empty' do
      proc { empty_s.pop } .must_raise EmptyStackError
    end
  end
end
