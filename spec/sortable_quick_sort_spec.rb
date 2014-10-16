require 'spec_helper'
using Sortable

describe 'Sortable' do
  let(:input)  { [*1..1_000] }
  let(:sorted) { [*1..1_000] }

  describe 'Array#quick_sort algorithm' do
    describe 'sorts arrays: ordered, suffled, reversed' do
      it { input.quick_sort.must_equal sorted }
      it { input.shuffle.quick_sort.must_equal sorted }
      it { input.reverse.quick_sort.must_equal sorted }
      it 'few elements yet repeated many times' do
        repeat_sorted = [[1]*250, [2]*250, [3]*250, [4]*250].flatten
        repeat_input = repeat_sorted.shuffle
        repeat_input.quick_sort.must_equal repeat_sorted
      end
    end

    describe 'fringe cases' do
      it { [1].quick_sort.must_equal [1] }
      it { [1, 1, 1, 1, 1].quick_sort.must_equal [1, 1, 1, 1, 1] }
      it { [7, 5, 5, 5, 5, 1, 2].quick_sort.must_equal [1, 2, 5, 5, 5, 5, 7] }
    end

    describe 'quick_sort benchmarking' do
      require 'minitest/benchmark'
      require 'benchmark'
      if ENV['BENCH']
        bench_performance_constant 'quick_sort RANDOM', 0.9999 do |_n|
          100.times { input.shuffle.quick_sort }
        end

        it 'is benchmarked for awesomeness' do
          puts 'Best'
          x = (1..100_000).to_a
          puts Benchmark.measure { x.quick_sort }
          puts 'Worst'
          x = x.reverse
          puts Benchmark.measure { x.quick_sort }
          puts 'Random'
          x = x.shuffle
          puts Benchmark.measure { x.quick_sort }
        end
      end
    end
  end
end
