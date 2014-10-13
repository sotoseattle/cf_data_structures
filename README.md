# Data Structures and Algorithms

## I. Insert Sort

My implementation has the following characteristics:

- takes advantage of Ruby methods like `insert` and `find_index` (Enumerable).
- monkeypatches Array but within a module that calls `refine`, so it both simpler to use and safer.
- returns a new sorted array without modifying self, like sort does.
- may not be the most efficient but I think it is pretty readable and simple.

<div style='text-align: center;'>
![](http://upload.wikimedia.org/wikipedia/commons/0/0f/Insertion-sort-example-300px.gif)
</div>

An interesting aspect is that although my implementation iterates the array elements from left to right, it then compares in the invariant array **_also left to right_** (unlike the example above in the image which is right to left).

This means that the **best scenario** (quickest sort) will happen when the array is already sorted in reverse order because it will keep on 'unshifting' to the front of the array (a single comparisson and insertion for each element), making the complexity linear: O(n).

The **worst scenario** (slowest sort) happens with an already sorted array, because it has to traverse from left to right the whole sorted yet partially formed array, and insert the element at the rightmost position. This means n (n-1) / 2 or O(n<sup>2</sup>)

##### Algorithm:

```ruby
def insert_sort # original readeable implementation
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
```

Which is refactored to a somewhat more cryptic:

```ruby
def insert_sort
  reduce([]) do |sorted, e|
    i = sorted.find_index { |x| e < x } || -1
    sorted.insert(i, e)
  end
end
```

It could be minimized into a single line, but then all readability goes away.

##### Call it like it is:

```ruby
require 'sortable'
using Sortable

p [3, 5, 2, 1].insert_sort  # =>  [1, 2, 3, 5]
```

Beware that neither irb nor pry understande 'refinements'. You'll need to execute a ruby file.

## Readings:

- [Ruby Algorithms: Sorting, Trie & Heaps](https://www.igvita.com/2009/03/26/ruby-algorithms-sorting-trie-heaps/)
