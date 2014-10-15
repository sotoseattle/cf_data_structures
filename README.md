# Data Structures and Algorithms

## I. Merge Sort

For Merge Sort, the ultimate divide and conquer algorithm  I have taken the shortcut of overpassing the divinding phase and just focus on the conquering. I start by breaking up the array into single element arrays contained into an encompassing array.

Then I iterate, each pass being a level up/down the binary tree , to sort each pair of consecutive sorted sub-arrays into a newly merged and sorted array.

The key is the use of the enumerable method each_slice(2) wich groups the sub-arrays into pairs, which can the be mapped into the newly sorted array.

At the end we have a single n-element array inside the container array, which we flatten to extract.

```
def merge_sort
  wip = each_slice(1).to_a
  wip = wip.each_slice(2).map { |a, b| merge_sorted(a, b) } while wip.size > 1
  wip.flatten
end
```

The workhorse method is merge_sorted, which takes two already sorted arrays as input and outputs a combined sorted array. The code is neither cute nor clever, but is readable, simple and efficient (leveraging pointers and while loop).

```
def merge_sorted(a, b)
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
  a[i] ? sol.concat(a[i..-1]) : sol.concat(b[j..-1])
end
```

It is nice to run the benchmarks and see that independently of how sorted they are have similar performances.

## II. Insert Sort

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
