require_relative '../linked_list/light_linked_list'

class HashTable < Array
  def get(key)
    list = self[position(key)]
    (list && (n = list.search(key))) ? n.holds : nil
  end

  def set(key, val)
    fail KeyHashTableError unless key.is_a? String
    index = position(key)
    self[index] ||= LightLinkedList.new
    self[index].insert(NodePlus.new(key, val))
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
