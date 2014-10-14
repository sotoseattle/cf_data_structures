require 'spec_helper'
using Sortable

describe 'Sortable' do
  let(:input)  { [*1..1_000] }
  let(:sorted) { [*1..1_000] }

  describe 'Array#insert_sort algorithm' do
    describe 'sorts arrays: ordered, suffled, reversed' do
      it { input.insert_sort.must_equal sorted }
      it { input.shuffle.insert_sort.must_equal sorted }
      it { input.reverse.insert_sort.must_equal sorted }
    end

    describe 'fringe cases' do
      it { [1].insert_sort.must_equal [1] }
      it { [1, 1, 1, 1].insert_sort.must_equal [1, 1, 1, 1] }
      it { [7, 5, 5, 5, 5, 1, 2].insert_sort.must_equal [1, 2, 5, 5, 5, 5, 7] }
    end

    describe 'insert_sort benchmarking' do
      require 'minitest/benchmark'
      if ENV['BENCH']
        bench_performance_constant 'insert_sort FAST', 0.9999 do |_n|
          100.times { input.insert_sort }
        end

        bench_performance_constant 'insert_sort RANDOM', 0.9999 do |_n|
          100.times { input.shuffle.insert_sort }
        end

        bench_performance_constant 'insert_sort SLOW', 0.9999 do |_n|
          100.times { input.reverse.insert_sort }
        end
      end
    end
  end

  describe 'Array#merge_sort algorithm' do
    describe 'sorts arrays: ordered, suffled, reversed' do
      it 'conquer!!!!' do
        [].conquer([1,2,3], [4,5,6]).must_equal [1,2,3,4,5,6]
        [].conquer([4,5,6], [1,2,3]).must_equal [1,2,3,4,5,6]
      end
    end

    describe 'sorts arrays: ordered, suffled, reversed' do
      it { input.merge_sort.must_equal sorted }
      it { input.shuffle.merge_sort.must_equal sorted }
      it { input.reverse.merge_sort.must_equal sorted }
    end

    describe 'fringe cases' do
      it { [1].merge_sort.must_equal [1] }
      it { [1, 1, 1, 1, 1].merge_sort.must_equal [1, 1, 1, 1, 1] }
      it { [7, 5, 5, 5, 5, 1, 2].merge_sort.must_equal [1, 2, 5, 5, 5, 5, 7] }
    end

    describe 'merge_sort benchmarking' do
      require 'minitest/benchmark'
      if ENV['BENCH']
        bench_performance_constant 'merge_sort FAST', 0.9999 do |_n|
          100.times { input.merge_sort }
        end

        bench_performance_constant 'merge_sort RANDOM', 0.9999 do |_n|
          100.times { input.shuffle.merge_sort }
        end

        bench_performance_constant 'merge_sort SLOW', 0.9999 do |_n|
          100.times { input.reverse.merge_sort }
        end
      end
    end
  end
end
