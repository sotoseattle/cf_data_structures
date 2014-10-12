# assumptions: 1) sort in ascending order, 2) admit repeated elements
module Sortable
  def insert_in_right_place(arr, e)
    arr.each_with_index do |x, i|
      return arr.insert(i, e) if e <= x
    end
    arr << e
  end

  def insert_sort(arr)
    sorted = [arr.shift]
    arr.each do |e|
      sorted = insert_in_right_place(sorted, e)
    end
    sorted
  end
end
