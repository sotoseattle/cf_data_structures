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
      return self if size <= 1

      self.shuffle! # fugly! would be better to => piv = rand(0...size)
      piv, j = 0, 1
      while j < size
        if to_the_left_yet_bigger?(piv, j) || to_the_right_yet_smaller?(piv,j)
          self[piv], self[j] = self[j], self[piv]
          piv, j = j, piv
        end
        j += 1
      end

      self[0...piv].quick_sort + [self[piv]] + self[piv+1..-1].quick_sort
    end

    def radix_sort
      to_sort = arrify_by_single_digits

      (0..."#{max}".length).each do |magnitude|
        to_sort = radix_level_sort(to_sort, magnitude)
      end

      to_sort.map { |a| a.join.to_i }
    end

    def sig_digit_at(order_of_magnitude)
      reverse[order_of_magnitude].to_i
    end

    private

    def radix_level_sort(arr_to_sort, magnitude)
      buckets = Hash[[*0..9].map {|x| [x, Array.new]}]
      arr_to_sort.each { |arr| buckets[arr.sig_digit_at(magnitude)] << arr }
      buckets.values.flatten(1)
    end

    def drain(bucket)
      bucket.each_key { |k| bucket[k] = [] }
      bucket
    end

    def arrify_by_single_digits
      self.map { |n| n < 10 ? [n] : "#{n}".chars.map { |c| c.to_i} }
    end

    def to_the_left_yet_bigger?(pivot, comp)
      comp < pivot && self[comp] > self[pivot]
    end

    def to_the_right_yet_smaller?(pivot, comp)
      pivot < comp && self[pivot] > self[comp]
    end
  end
end

# using Sortable
# p [3,2,5,10,201,1].radix_sort
