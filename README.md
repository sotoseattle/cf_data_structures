# Data Structures and Algorithms

## I. Insert Sort

My implementation has the following characteristics:

- takes advantage of Ruby methods like `insert` and `rindex`.
- monkeypatches Array but within a module that calls `refine`, so it both simpler to use and safer.
- returns a new sorted array without modifying self, just like sort does.
- may not be the most efficient (use of reduce) but I think it is pretty readable and simple.

##### Algorithm:

```ruby
def insert_sort # original readeable implementation
  sorted = []
  self.each do |e|
    if (i = sorted.rindex { |x| x <= e })
      sorted.insert(i+1, e)
    else
      sorted.insert(0, e)
    end
  end
  sorted
end
```

Which is refactored to a somewhat more cryptic:

```ruby
def insert_sort
  reduce([]) do |sorted, e|
    i = sorted.rindex { |x| x <= e } || -1
    sorted.insert(i+1, e)
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

## Contribuitors:

- Javier Soto
- Derek Maffet, who realized that to make Insert Sort stable the condition should be x <= e instead of simple x < e

## Readings:

- [Ruby Algorithms: Sorting, Trie & Heaps](https://www.igvita.com/2009/03/26/ruby-algorithms-sorting-trie-heaps/)
