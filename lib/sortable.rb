# assumptions: 1) sort in ascending order, 2) admit repeated elements
module Sortable
  refine Array do
    def insert_sort
      sorted = []
      self.each do |e|
        if (i = sorted.find_index { |x| e < x })
          sorted.insert(i, e)
        else
          sorted << e
        end
      end
      sorted
    end
  end
end
