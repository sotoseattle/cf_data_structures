require 'spec_helper'

describe LinkQueue do
  let(:empty_q) { LinkQueue.new }
  let(:q) do
    q = LinkQueue.new
    q.enqueue(23)
    q.enqueue('24')
    q.enqueue(0)
    q
  end

  describe 'LinkQueue#enqueue' do
    it 'inserts in an empty queue' do
      empty_q.enqueue(23)
      empty_q.size.must_equal 1
      empty_q.to_s.must_equal '23'
    end

    it 'inserts in a dequeueulated queue at the top' do
      q.size.must_equal 3
      q.to_s.must_equal '0, 24, 23'
    end
  end

  describe 'LinkQueue#dequeue' do
    it 'returns the element data' do
      q.dequeue.must_equal 23
    end

    it 'removes the element' do
      q.dequeue
      q.size.must_equal 2
      q.to_s.must_equal '0, 24'
      q.search(23).must_equal nil
    end

    it 'removes the elements' do
      q.dequeue
      q.dequeue
      q.size.must_equal 1
      q.to_s.must_equal '0'
    end

    it 'throws exception if queue is already empty' do
      proc { empty_q.dequeue }.must_raise EmptyQueueError
    end
  end
end
