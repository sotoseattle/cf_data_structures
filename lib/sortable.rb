# assumptions: 1) sort in ascending order, 2) admit repeated elements
module Sortable
  def insert_sort(arr)
    sorted = []
    arr.each do |e|
      if (i = sorted.find_index { |x| e < x })
        sorted.insert(i, e)
      else
        sorted << e
      end
    end
    sorted
  end
end
