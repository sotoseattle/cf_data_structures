require 'spec_helper'

describe HashTable do
  let(:empty_h_10) { HashTable.new(10) }

  describe 'HashTable#new' do
    it 'allocates itself as a fixed sized array' do
      empty_h_10.size.must_equal 10
      empty_h_10.must_be_kind_of Array
    end
  end

  describe 'HashTable#hash' do
    it 'computes the right number as hash function' do
      empty_h_10.send(:hash, 'pepe').must_equal 426
      empty_h_10.send(:hash, 'epep').must_equal 426
      empty_h_10.send(:hash, 'eepp').must_equal 426
      empty_h_10.send(:hash, 'ppee').must_equal 426
      empty_h_10.send(:hash, 'pee').wont_equal 426
    end
  end

  describe 'HashTable#set' do
    it 'raises error if key is not a string' do
      assert_raises RuntimeError do
        empty_h_10.set(0, 'something')
      end
    end

    it 'sets the element in an empty spot' do
      key = 'pepe'
      empty_h_10.set(key, 42)
      i = empty_h_10.send(:hash, key) % empty_h_10.size
      ll = empty_h_10[i]
      ll.must_be_kind_of LightLinkedList
      ll.head.val.must_equal 'pepe'
      ll.head.holds.must_equal 42
    end

    it 'sets the element in a prefilled spot' do
      empty_h_10.set('pepe', 42)
      empty_h_10.set('epep', 24)
      empty_h_10.set('eepp', 0)
      i = empty_h_10.send(:hash, 'pepe') % empty_h_10.size
      ll = empty_h_10[i]
      ll.must_be_kind_of LightLinkedList
      ll.head.holds.must_equal 0
      ll.head.nexxt.holds.must_equal 24
      ll.head.nexxt.nexxt.holds.must_equal 42
    end
  end

  describe 'HashTable#get' do
    let(:ht) do
      ht = HashTable.new(10)
      ht.set('pepe', 3)
      ht.set('epep', 2)
      ht.set('eepp', 1)
      ht.set('ppee', 0)
      ht
    end

    it 'if unoccupied, the array cell holds a nil' do
      ht[0].must_be_nil
    end

    it 'if key not found return nil' do
      ht.get('hola').must_be_nil
    end

    describe 'if key found return value' do
      it 'when there is a single node in the list' do
        empty_h_10.set('pepe', 42)
        empty_h_10.get('pepe').must_equal 42
      end

      it 'when there are a multiple nodes in the list and key is in the head' do
        ht.get('ppee').must_equal 0
      end

      it 'when there are a multiple nodes in the list and key is in the tail' do
        ht.get('pepe').must_equal 3
      end

      it 'when there are a multiple nodes in the list and key is in the middle' do
        ht.get('eepp').must_equal 1
      end
    end
  end

  describe 'volumen test' do
    let(:huge_table) do
      huge_table = HashTable.new(100_000)
      File.open('/usr/share/dict/words', 'r') do |f|
        f.each_line do |line|
          w = line.strip.chomp
          huge_table.set(w, w.reverse)
        end
      end
      huge_table
    end

    it 'crams over 250,000 words inside an array of size 100,000' do
      huge_table.get('pear').must_equal 'raep'
      huge_table.get('colibri').must_equal 'colibri'.reverse
      huge_table.get('collibri').wont_equal 'collibri'.reverse
    end
  end
end
