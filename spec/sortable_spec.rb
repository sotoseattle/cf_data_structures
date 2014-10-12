require 'spec_helper'

describe 'Sort#insert_sort' do
  describe 'sorts arrays' do
    let(:input) {[*1..1000]}
    let(:sorted) {[*1..1000]}

    it 'sorts it out' do
      insert_sort(input.shuffle).must_equal sorted
    end

    it 'worst case scenario: already sorted' do
      insert_sort(input).must_equal sorted
    end

    it 'best case scenario: reversed' do
      insert_sort(input.reverse).must_equal sorted
    end
  end

  describe 'fringe cases' do
    it 'single element' do
      insert_sort([1]).must_equal [1]
    end

    it 'single repeated element' do
      insert_sort([1,1,1,1]).must_equal [1,1,1,1]
    end

    it 'random repeated element' do
      insert_sort([4,7,5,5,5,5,1,9,2,8]).must_equal [1,2,4,5,5,5,5,7,8,9]
    end
  end
end
