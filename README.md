DATA STRUCTURES & ALGORITHMS
============================

## Code Fellows Practice & Exercises

![Travis](https://travis-ci.org/sotoseattle/cf_data_structures.svg?branch=master)

Table of Contents
=================

- [Data Structures](#data-structures)
    - [Linked List](#linked-list)
    - [Double Linked List](#double-linked-list)
    - [Queue](#queue)
    - [Stack](#stack)
    - [Hash](#hash)
    - [Binary Tree Traversal](#binary-tree-traversal)
- [Sorting Algorithms](#sorting-algorithms)
    - [Insert Sort](#insert-sort)
    - [Merge Sort](#merge-sort)
    - [Quick Sort](#quick-sort)
    - [Radix Sort](#radix-sort)
- [Authors](#authors)
- [License](#license)

Data Structures
===============

Linked List
-----------

#### As a Linked List of Nodes

I use an ad-hoc class for nodes with a very simple design:

* A node holds only a value and a link to the next node
* A node has an intuitive public interface:
    * **new**
    * **val** => returns the value it holds
    * **nexxt** => returns the next node it points to, or nil if none
    * **nexxt=** => sets the next node it points to
    * **detach** => make it point to nil, so it can be GC
    * **to_s** => returns the held value as a string
* Only a node can change himself the value it holds or to where it points to

Of mention is the fact that when we detach a node, it returns the value it holds. This is a small utility behavior that simplifies the code of the linked list.

A Linked List Object only holds two things which cannot be seen nor accessed from outside the list:

* the **head**, A pointer to the first element of the list.
* a traversor, an Enumerator object that adds traversing functionality and simplifies the code.

The traversor just walks the list from the head until its end, yielding any possible block for each node walked by.
```ruby
@traversor = Enumerator.new do |y|
  node = head
  while node
    y << node
    node = node.next
  end
end
```

The public interface consists of:

* **new**
* **size** => returns the number of nodes in list
* **insert(node)** => at head (LIFO)
* **serch(node)** => returns val or nil if not found
* **remove(node)** => detaches node and bridges between pre and post nodes
* **to_s** => returns a string of nodes' values
* **to_a** => returns an array of nodes

The initiliazer returns self so we can chain methods.

The insert method adds a node to the head of the list. I have chosen not to use parallel assignment because I rather left to the node the actual setting of the link. This is a compromise between simplicity of the code and readability and decoupling. The insert method also returns the list so we can chain multiple insertions together.

The size method just counts the number of elements in the traversor. This is another compromise. I could have kept count with an instance variable and add/substract everytime I insert/remove a node. But I rather keep things simple, and only call size when needed, even if then it will need to walk the whole list.

```ruby
def size
  traversor.count
end
```

The rest of methods are self-explanatory.

#### As Nodes Linked

Instead of having a List object, we just have nodes pointing to nodes.
Self explanatory and very similar to the previous.
We create our own traversor and use it extensively.

```ruby
def walk(&block)
  n = self
  while n
    yield(n)
    n = n.nexxt
  end
end
```

Double Linked List
------------------

Inherits most of its behavior from the Light Linked List. We only override the  insert and remove methods to make sure we track correctly both previous and next nodes.

Also, this linked list is not comprised of Nodes, but of DoubleNodes, another subclass of Nodes that allows us to reference both: next and previous linked nodes. We added a detach method to simplify the code.

The deduplicate method removes repeated nodes preserving the first one (starting from the head). The tests are extensive:

```ruby
describe 'DoubleLinkedList#deduplicate' do
  it 'removes duplicated nodes by val from the list' do
    my_dl = DoubleLinkedList.new
    200.times { my_dl.insert(DoubleNode.new(rand(100))) }
    my_dl.deduplicate
    my_dl.to_a.size.must_equal my_dl.to_a.uniq.size
  end

  it 'is stable => keeps the first deduplicated node starting from the head' do
    my_dl = DoubleLinkedList.new
    [8, 4, 2, 4, 9, 4, 8, 8, 0, 3].reverse.each do |e|
      my_dl.insert(DoubleNode.new(e))
    end
    my_dl.deduplicate
    my_dl.to_s.must_equal "8, 4, 2, 9, 0, 3"
  end
end
```

The method is simple except for an ugly preservation of the pointed node at removal. We keep track of existing nodes with a hash. It has O(n) time complexity.

```ruby
def deduplicate
  existing, n = {}, head
  while n
    if existing[n.val]
      m = n.nexxt
      bridge(n)
      n = m
    else
      existing[n.val], n = true, n.nexxt
    end
  end
end
```

Without the hash to keep track we would need to re-iterate for each node, making it O(n^2).

```ruby
def deduplicate_On2
  n = head
  while n
    forward_remove(n.nexxt, n)
    n = n.nexxt
  end
end

private

def forward_remove(start, target)
  n = start
  while n
    m = n.nexxt
    bridge(n) if n.val == target.val
    n = m
  end
end
```

Queue
-----

My Queue inherits from Light Linked List, which simplifies the code tremendously.

The Light Linked List is the simplest Linked List that uses both Nodes and Linked List objects ().

The Queue's enqueue method is analogous to the insert method with a small difference, we insert stuff into the Stack, not Nodes. So we wrap the stuff into a Node in the enqueue method prior to inserting this wrapper Node.

```ruby
def enqueue(val)
  insert(Node.new(val))
end
```

The dequeue method is also analogous to remove, we just need to specify inside our method that the node we remove is the tail. To do this we literally run down the chain until the last node, which we remove.

```ruby
def dequeue
  fail RuntimeError.new('EmptyStackError') unless head
  n = head
  n = n.nexxt while n.nexxt
  remove n
end
```

Finally, I made the inherited insert and remove methods protected so they cannot be access by mistake in the Queue, and the API is coherent.

```ruby
class Queue < LightLinkedList
  protected :insert, :remove
  ...
end
```

Stack
-----

My Stack inherits from Light Linked List, which simplifies the code tremendously.

The Light Linked List is the simplest Linked List that uses both Nodes and Linked List objects ().

The Stack's push method is analogous to the insert method with a small difference, we insert stuff into the Stack, not Nodes. So we wrap the stuff into a Node in the push method prior to inserting this wrapper Node.

```ruby
def push(datum)
  insert(Node.new(datum))
end
```

The pop method is also analogous to remove, we just need to specify inside our method that the node we remove is the head.

```ruby
def pop
  fail RuntimeError.new('EmptyStackError') unless head
  remove(head)
end
```

Finally, I made the inherited insert and remove methods protected so they cannot be access by mistake in the Stack, and the API is coherent.

```ruby
class Stack < LightLinkedList
  protected :insert, :remove
  ...
end
```

Hash
----

My HashTable inherits from Array and initializes to an intial fixed size.

It uses two classes from this package:

1- Linked Lists. It stores in its cells Linked Lists (LightLinkedList).
2- The lists are comprised of mutated Nodes (NodePlus) that inherit from Node and which hold as the Node.val the key (string), and as the Node.holds the actual value associated with the key. This NodePlus class is private and unseen from outside the HashTable class.

```ruby
class NodePlus < Node
  attr_reader :holds
  def initialize(key, value)
    @holds = value
    super(key)
  end
end
```

The public API is based on only two methods set and get.

We have an additional two private methods: one computes the position in the array based on the key.
The other computes the hash function. I have made this last one private because I don't see what goal it serves to make it publicly accessibe.

```ruby
private

def hash(key)
  key.chars.map(&:ord).reduce(:+)
end

def position(str)
  hash(str) % size
end
```

I include the usual unit tests and an additional volume test based on the over 250,000 words from the file '/usr/share/dict/words'.'

Binary Tree Traversal
---------------------

Not BST, but normal Binary Trees. Here we explore 3 depth-first traversal methods to walk a tree.

To simplify things we make BT as simple nodes as we used them in the Light Linked List, with two links instead of one.

The recursive nature for traversing the tree is the same in all cases: if able keep on exploring down the side of the tree.

```ruby
left.traverse_pre_order if left
right.traverse_pre_order if right
```

The only thing that changes is where we 'pick' the val of the node (or examine the node): before, in between or after both recursive calls.
We wrap this in an array, path, so we can see the path walked along the tree.

```ruby
def traverse_pre_order
  puts val
  left.traverse_pre_order if left
  right.traverse_pre_order if right
end

def traverse_in_order
  left.traverse_in_order if left
  puts val
  right.traverse_in_order if right
end

def traverse_post_order
  left.traverse_post_order if left
  right.traverse_post_order if right
  puts val
end
```

The test includes a hardwired tree on which we test the methods.

My pre-final version uses metaprogramming making somewhat less verbose but may more opaque:

```ruby
class BinaryTree
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left = @right = nil
  end

  %w[pre in post].each_with_index do |prefix, index|
    define_method("traverse_#{prefix}_order") do
      left_to_right = [
        -> { left.public_send("traverse_#{prefix}_order") if left },
        -> { right.public_send("traverse_#{prefix}_order") if right }]
      do_stuff = -> { puts val }
      left_to_right.insert(index, do_stuff)
      left_to_right.each { |x| x.yield }
    end
  end
end
```

And my final version just goes bananas and metaprogramms just for the sake of it.

```ruby
class BinaryTree
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left = @right = nil
  end

  %w[pre in post].each_with_index do |prefix, index|
    define_method("traverse_#{prefix}_order") do
      instructions(prefix).insert(index, do_stuff).each(&:yield)
    end
  end

  private

  def do_stuff
    -> { puts val }
  end

  def instructions(prefix)
    [left, right].map { |e| -> { e.send("traverse_#{prefix}_order") if e } }
  end
end
```

The ad-hoc tests made (tests for the correct output to stdout) pass.

Sorting Algorithms
==================

Insert Sort
-----------

My implementation has the following characteristics:

- takes advantage of Ruby methods like `insert` and `rindex`.
- returns a new sorted array without modifying self, just like sort does.
- may not be the most efficient (use of reduce) but I think it is pretty readable and simple.

Algorithm:

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


I am monkeypatching Array but within a module that calls `refine`, so it both simpler to use and safer.

Merge Sort
----------

There are two separate parts to the algorithm:

1- Walking down/up the binary tree. Each iteration, one level where we merge pairs of sub-arrays.
2- The merging of sub-arrays itself.

This second part has been coded as an Array method, similar to an Enumerable iterator. Takes in another array to merge with, and a block. Extrude iterates over each element of each array, starting from the left, and queries if the block passed evaluates to true when comparing the elements selected in both arrays. Visually, is similar extruding two metals in metallurgy.

This method is 30% slower than my previous version (without block passing). But the performance hit is still so small that, in the bigger scheme of things, this is small potatoes when compared with gaining a great new enumerable-like method to use with arrays.

```
def extrude(other)
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

Quick Sort
----------

A simple recursive algorithm. It shuffles the array, chooses as pivot the first element and finds its way to its final position by swapping with others until all the elements to its left are smaller and the ones to the right are bigger.

Then, it calls itself to each subarray (left and right), fixing in place the pivot.

```ruby
def quick_sort
  return self if size <= 1

  self.shuffle! # fugly! would be better to => piv = rand(0...size)
  piv, j = 0, 1
  while j < size
    if to_the_left_yet_bigger?(piv, j) || to_the_right_yet_smaller?(piv,j)
      self[piv], self[j] = self[j], self[piv]
      piv, j = j, piv
    end
    j += 1
  end

  self[0...piv].quick_sort + [self[piv]] + self[piv+1..-1].quick_sort
end
```

Radix Sort
----------

Very simple implementation I tried to make it as readeable as possible.

I use strings instead of numbers because they are easier to manipulate in this case.

The key happens in every iteration when we place the numbers in their corresponding buckets and then unload the buckets back.

```ruby
def radix_level_sort(arr_to_sort, order_of_magnitude)
  bucket = Hash[[*0..9].map {|x| [x, Array.new]}]
  arr_to_sort.each do |str|
    bucket[significant_digit(str, order_of_magnitude)] << str
  end
  bucket.values.flatten
end
```

The work of iterating over the maginute order levels become trivial

```ruby
def radix_sort
  to_sort = map(&:to_s)
  (0..."#{max}".length).each do |order_of_magnitude|
    to_sort = radix_level_sort(to_sort, order_of_magnitude)
  end
  to_sort.map(&:to_i)
end
```

Author:
=======

- Javier Soto

License
=======

The MIT License

Copyright (c) 2014 Javier Soto

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
