# Data Structures and Algorithms

I am monkeypatching Array but within a module that calls `refine`, so it both simpler to use and safer.

## I. Merge Sort

There are two separate parts to the algorithm:

1- Walking down/up the binary tree. Each iteration, one level where we merge pairs of sub-arrays.
2- The merging of sub-arrays itself.

This second part has been coded as an Array method, similar to an Enumerable iterator. Takes in another array to merge with, and a block. Extrude iterates over each element of each array, starting from the left, and queries if the block passed evaluates to true when comparing the elements selected in both arrays. Visually, is similar extruding two metals in metallurgy.

This method is 30% slower than my previous version (without block passing). But the performance hit is still so small that, in the bigger scheme of things, this is small potatoes when compared with gaining a great new enumerable-like method to use with arrays.

```
def extrude(other, &block)
  return self unless other
  sol = []
  i, j = 0, 0
  while self[i] && other[j]
    if yield(self[i], other[j])
      sol << self[i]
      i += 1
    else
      sol << other[j]
      j += 1
    end
  end
  self[i] ? sol.concat(self[i..-1]) : sol.concat(other[j..-1])
end
```

Now that we know how to merge two arrays in this manner, we can focus on the iterations themselves.

Let me start by saying that even if this is the ultimate divide and conquer algorithm I have taken the shortcut of overpassing the dividing phase and just focus on the conquering. Instead of recursively dividing the array in smaller arrays, I start by breaking it up into single element arrays contained into an encompassing array.

Then I iterate, each pass being a level up/down the binary tree , to sort each pair of consecutive sorted sub-arrays into a newly merged and sorted array.

The key is the use of the enumerable method each_slice(2) which groups the sub-arrays into pairs, which can the be mapped into the newly sorted array.

At the end we have a single n-element array inside the container array, which we flatten to extract.

```
def merge_sort
  wip = each_slice(1).to_a
  while wip.size > 1
    wip = wip.each_slice(2).map do |a, b|
      a.extrude(b) { |x, y| x <= y }
    end
  end
  wip.flatten
end
```

It is nice to run the benchmarks and see that independently of how sorted they are have similar performances.

## II. Insert Sort

My implementation has the following characteristics:

- takes advantage of Ruby methods like `insert` and `rindex`.
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

Beware that neither irb nor pry understand 'refinements'. You'll need to execute a ruby file.

## Contributors:

- Javier Soto
- Derek Maffet, who realized that to make Insert Sort stable the condition should be x <= e instead of simple x < e
- Sunny Mittal's comparison benchmarking is an incentive to aim for better performance.

## Readings:

- [Ruby Algorithms: Sorting, Trie & Heaps](https://www.igvita.com/2009/03/26/ruby-algorithms-sorting-trie-heaps/)
