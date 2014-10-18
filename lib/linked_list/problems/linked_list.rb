require '../light_linked_list'

# http://cslibrary.stanford.edu/105/LightLinkedListProblems.pdf

# 1.- Write a Count() function that counts the number of times a given int occurs in a list.
# The code for this has the classic list traversal structure as demonstrated in Length().

def abc
  [Node.new('A'), Node.new('B'), Node.new('C')]
end

def setup(a,b,c)
  ll = LightLinkedList.new
  ll.insert(c)
  ll.insert(b)
  ll.insert(a)
  ll
end

a,b,c = abc
ll = setup(a,b,c)

class LightLinkedList
  def count(node)
    i = 0
    n = head
    while n
      i += 1 if n == node
      n = n.nexxt
    end
    i
  end
end

puts "count" + "_"*40
p "#{ll.count(b)} == 1"

# 2.- Write a GetNth() function that takes a linked list and an integer index and
# returns the data value stored in the node at that index position.

class LightLinkedList
  def get_nth(j)
    i = 0
    n = head
    while n
      return n if i == j
      n = n.nexxt
      i += 1
    end
    i
  end
end

puts "get_nth" + "_"*40
p "#{ll.get_nth(1)} == #{b}"

# 3.- Write a function DeleteList() that takes a list, deallocates all of its
# memory and sets its head pointer to NULL (the empty list).

class LightLinkedList
  def delete_list
    n = head
    @head = nil
    while n
      t, n.nexxt = n.nexxt, nil
      n = t
    end
  end
end

ll.delete_list
puts "delete_list" + "_"*40
p "#{ll.head.class} == nil"
p "#{ll.size} == 0"

# 4.- Write a Pop() function that is the inverse of Push(). Pop() takes a non-empty
# list, deletes the head node, and returns the head node's data.

class LightLinkedList
  def pop
    t = head
    @head = head.nexxt
    t.nexxt = nil
    return t
  end
end

a,b,c = abc
ll = setup(a,b,c)
x = ll.pop
puts "pop" + "_"*40
p "#{x.val} == A"
p "#{ll.size} == 2"

# 5.- A more difficult problem is to write a function InsertNth() which can insert
# a new node at any index within a list. The caller may specify any index in the
# range [0..length], and the new node should be inserted so as to be at that index.

class LightLinkedList
  def insert_at(node, j)
    i = 0
    n = head
    prev = nil
    while n
      if i == j
        node.nexxt = n
        prev.nexxt = node
        return
      end
      prev = n
      n = n.nexxt
      i += 1
    end
  end
end

a,b,c = abc
ll = setup(a,b,c)
d = Node.new('D')
ll.insert_at(d, 1)
puts "insert_at" + "_"*40
p "#{ll.get_nth(1)} == D"
p "#{ll.get_nth(0).nexxt} == D"
p "#{ll.get_nth(1).nexxt} == B"
p "#{ll.size} == 4"

# 6.- Write a SortedInsert() function which given a list that is sorted in increasing
# order, and a single node, inserts the node into the correct sorted position in the list.

class LightLinkedList
  def sorted_insert(node)
    return insert(node) if head == node
    prev = head
    n = head.nexxt
    while n
      if prev.val <= node.val && node.val < n.val
        prev.nexxt = node
        node.nexxt = n
        return
      end
      prev = n
      n = n.nexxt
    end
  end
end

a,b,c = abc
d = Node.new('D')
ll = setup(a,b,d)
puts "sorted_insert" + "_"*40
p "sorted [#{ll}] inserting C"
ll.sorted_insert(c)
p "sorted [#{ll}] inserted C == [A, B, C, D]"
p "#{ll.size} == 4"

# 7.- Write an InsertSort() function which given a list, rearranges its nodes so
# they are sorted in increasing order.

class LightLinkedList

  def insert_sort(node)
    # prev = nil
    # n = head
    # while n
    #   swap if n.next < n

    #   prev = n
    #   n = n.nexxt
    # end
  end
end

a,b,c = abc
d = Node.new('D')
ll = setup(d,b,a,c)
puts "insert_sort" + "_"*40
p "unsorted [#{ll}]"
ll.insert_sort
p "sorted [#{ll}] == [A, B, C, D]"
























