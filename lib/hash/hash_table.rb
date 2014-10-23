require_relative '../linked_list/light_linked_list'

class HashTable < Array
  def get(key)
    list = self[position(key)]
    if list && (n = list.search(key))
      return n.holds
    end
    nil
  end

  def set(key, val)
    fail KeyHashTableError unless key.is_a? String
    index = position(key)
    if self[index]
      self[index].insert(NodePlus.new(key, val))
    else
      self[index] = LightLinkedList.new.insert(NodePlus.new(key, val))
    end
  end

  private

  def hash(key)
    key.chars.map(&:ord).reduce(:+)
  end

  def position(str)
    hash(str) % size
  end

  class NodePlus < Node
    attr_reader :holds
    def initialize(key, value)
      @holds = value
      super(key)
    end
  end
end
