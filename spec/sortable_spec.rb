require 'spec_helper'
using Sortable

describe 'Array#insert_sort algorithm' do
  describe 'sorts arrays' do
    let(:input) { [*1..1000] }
    let(:sorted) { [*1..1000] }

    it 'sorts it out' do
      input.shuffle.insert_sort.must_equal sorted
    end

    it 'worst case scenario: already sorted' do
      input.insert_sort.must_equal sorted
    end

    it 'best case scenario: reversed' do
      input.reverse.insert_sort.must_equal sorted
    end
  end

  describe 'fringe cases' do
    it 'single element' do
      [1].insert_sort.must_equal [1]
    end

    it 'single repeated element' do
      [1, 1, 1, 1].insert_sort.must_equal [1, 1, 1, 1]
    end

    it 'random repeated element' do
      [7, 5, 5, 5, 5, 1, 2, 8].insert_sort.must_equal [1, 2, 5, 5, 5, 5, 7, 8]
    end
  end
end
