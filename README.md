# Data Structures and Algorithms

## Insert Sort

Basic find and insert algorithm.


My implementation has the following characteristics:

- although it iterates the array elements from left to right, it then compares in the invariant array also left to right (unlike the example in wikipedia which is right to left).
- takes advantage of Ruby methods like `insert` and `find_index` (Enumerable)
- monkeypatches Array but within a module that calls `refine`, so it both simpler to use and safer.
- returns a new sorted array
- may not be the most efficient but I think it is pretty readable and simple:

##### Algorithm:

```ruby
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

p [3, 5, 2, 1].insert_sort

=> [1, 2, 3, 5]
```

Beware that neither irb nor pry understande 'refinements'. You'll need to execute a ruby file.
