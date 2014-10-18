require '../light_linked_list'

# http://cslibrary.stanford.edu/105/LightLinkedListProblems.pdf

# 1.- Write a Count() function that counts the number of times a given int occurs in a list.
# The code for this has the classic list traversal structure as demonstrated in Length().

a = Node.new('A')
b = Node.new('B')
c = Node.new('C')
ll = LightLinkedList.new
ll.insert(c)
ll.insert(b)
ll.insert(a)

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

# 4.-



