module Sortable
  refine Array do

    # Enumerable method
    def extrude(other)
      return self unless other
      sol = []
      i, j = 0, 0
      while self[i] && other[j]
        if yield(self[i], other[j])
          sol << self[i]
          i += 1
        else
          sol << other[j]
          j += 1
        end
      end
      self[i] ? sol.concat(self[i..-1]) : sol.concat(other[j..-1])
    end

    # Sorting methods
    def insert_sort
      reduce([]) do |acc, ele|
        i = acc.rindex { |x| x <= ele } || -1
        acc.insert(i + 1, ele)
      end
    end

    def merge_sort
      wip = each_slice(1).to_a
      while wip.size > 1
        wip = wip.each_slice(2).map do |a, b|
          a.extrude(b) { |x, y| x <= y }
        end
      end
      wip.flatten
    end

    def quick_sort
      return self if size < 2

      i, j = 0, 1
      while j < size
        compare_and_swap(i,j)
        j += 1
      end

      self[0...i].quick_sort + [self[i]] + self[i+1..-1].quick_sort
    end

    private

    def on_left_yet_bigger?(pivot, j)
      j < pivot && self[j] > self[pivot]
    end

    def on_right_yet_smaller?(pivot, j)
      j > pivot && self[j] <= self[pivot]
    end

    def compare_and_swap(pivot, j)
      if on_left_yet_bigger?(pivot, j) || on_right_yet_smaller?(pivot, j)
        self[pivot], self[j] = self[j], self[pivot]
        pivot, j = j, pivot
      end
    end
  end
end

# using Sortable
# p [4, 6, 3, 1, 5, 2].quick_sort
# a = [*1..1_000].shuffle.quick_sort
# p a[0..10]
