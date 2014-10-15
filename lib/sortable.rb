module Sortable
  refine Array do

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
  end
end
