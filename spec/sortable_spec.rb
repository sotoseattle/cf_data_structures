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
      # if ENV['BENCH']
      #   bench_performance_constant 'insert_sort FAST', 0.9999 do |_n|
      #     100.times { input.insert_sort }
      #   end

      #   bench_performance_constant 'insert_sort RANDOM', 0.9999 do |_n|
      #     100.times { input.shuffle.insert_sort }
      #   end

      #   bench_performance_constant 'insert_sort SLOW', 0.9999 do |_n|
      #     100.times { input.reverse.insert_sort }
      #   end
      # end
    end
  end

  describe 'Array#merge_sort algorithm' do
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
      require 'benchmark'
      if ENV['BENCH']
        bench_performance_constant 'merge_sort ORDERED', 0.9999 do |_n|
          100.times { input.merge_sort }
        end

        bench_performance_constant 'merge_sort RANDOM', 0.9999 do |_n|
          100.times { input.shuffle.merge_sort }
        end

        bench_performance_constant 'merge_sort REVERSED', 0.9999 do |_n|
          100.times { input.reverse.merge_sort }
        end

        it 'is benchmarked for awesomeness' do
          puts 'Best'
          puts Benchmark.measure { (1..100_000).to_a.merge_sort }
          puts 'Worst'
          puts Benchmark.measure { 100_000.downto(1).to_a.merge_sort }
          puts 'Random'
          puts Benchmark.measure { (1..100_000).to_a.shuffle.merge_sort }
        end
      end
    end
  end
end
