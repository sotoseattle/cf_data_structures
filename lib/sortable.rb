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
      self.shuffle!
      return self if size <= 1

      i, j = 0, 1
      while j < size
        i, j = compare_and_swap(i,j) if i < j
        j, i = compare_and_swap(j,i) if i > j
        j += 1
      end

      left_side(i) + [self[i]] + right_side(i)
    end

    private

    def left_side(i)
      self[0...i].quick_sort
    end

    def right_side(i)
      self[i+1..-1].quick_sort
    end

    def compare_and_swap(x, y)
      if self[y] < self[x]
        self[x], self[y] = self[y], self[x]
        x, y = y, x
      end
      [x, y]
    end
  end
end
