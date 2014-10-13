module Sortable
  refine Array do
    def insert_sort
      reduce([]) do |sorted, e|
        i = sorted.find_index { |x| e < x } || -1
        sorted.insert(i, e)
      end
    end
  end
end
