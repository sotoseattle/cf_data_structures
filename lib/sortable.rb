module Sortable
  refine Array do
    def insert_sort
      reduce([]) do |sorted, e|
        i = sorted.rindex { |x| x <= e } || -1
        sorted.insert(i + 1, e)
      end
    end
  end
end
