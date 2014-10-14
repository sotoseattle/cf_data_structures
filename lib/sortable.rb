module Sortable
  refine Array do
    def insert_sort
      reduce([]) do |acc, ele|
        i = acc.rindex { |x| x <= ele } || -1
        acc.insert(i + 1, ele)
      end
    end

    def merge_sort
      wip = each_slice(1).to_a
      wip = wip.each_slice(2).map { |a, b| merge_arr(a, b) } while wip.size > 1
      wip.flatten
    end

    private

    def merge_arr(a, b)
      return a unless b
      sol = []
      i, j = 0, 0
      while a[i] && b[j]
        if a[i] <= b[j]
          sol << a[i]
          i += 1
        else
          sol << b[j]
          j += 1
        end
      end
      sol.concat(b[j..-1]).concat(a[i..-1])
    end
  end
end
