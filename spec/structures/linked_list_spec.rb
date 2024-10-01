# frozen_string_literal: true

require 'rspec'
require_relative '../../src/structures/linked_list'

describe LinkedList do
  describe '::new' do
    it 'returns a new instance of LinkedList' do
      expect(LinkedList.new).to be_an_instance_of(LinkedList)
    end

    it 'should create an empty list' do
      l = LinkedList.new
      expect(l.empty?).to be(true)
    end

    it 'should create a list of length 0' do
      l = LinkedList.new
      expect(l.length).to eq(0)
      # Aliases
      expect(l.count).to eq(0)
      expect(l.size).to eq(0)
    end
  end

  describe 'cons' do
    it 'should add an element to the front of the list' do
      l = LinkedList.new
      expect(l.first).to eq(nil)

      l.cons(1)
      expect(l.first).to eq(1)

      l.cons(2)
      expect(l.first).to eq(2)

      l.cons(3)
      expect(l.first).to eq(3)

      expect(l.length).to eq(3)
    end

    it 'should allow for chaining' do
      l = LinkedList.new
      expect(l.cons(1).cons(2).cons(3).first).to eq(3)
    end
  end

  describe 'cons_each' do
    it 'should cons everything in the enumerable' do
      l = LinkedList.new
      l.cons_each([1, 2, 3])
      expect(l.length).to eq(3)
      expect(l.first).to eq(3)
    end

    it 'should work with non-empty lists' do
      l = LinkedList.new
      l.cons(1).cons(2).cons(3)

      l.cons_each([4, 5])
      expect(l.length).to eq(5)
      expect(l.first).to eq(5)
    end

    it 'should allow for chaining' do
      l = LinkedList.new
      expect(
        l.cons_each([2, 4, 6]).cons_each([3, 5, 7]).length
      ).to eq(6)
    end

    # cons_each is the only one that works with
    # any enumerable. append_each takes lists only
    it 'should work with varying enumerables' do
      l1 = LinkedList.new
      l1.cons_each([1, 2, 3])
      expect(l1.length).to eq(3)

      l2 = LinkedList.new
      l2.cons_each(1..10)
      expect(l2.length).to eq(10)

      l3 = LinkedList.new
      l3.cons_each({ foo: 'bar', baz: 'qux' })
      expect(l3.length).to eq(2)
      expect(l3.first).to eq([:baz, 'qux'])
    end
  end

  describe 'append' do
    it 'should add items to the end of the list' do
      l = LinkedList.new
      l.append(1)
      l.append(2)
      l.append(3)

      expect(l.length).to eq(3)
      expect(l.first).to eq(1)
    end

    it 'should work with non-empty lists' do
      l = LinkedList.new
      l.cons_each([1, 2, 3])

      l.append_each([1, 2, 3])

      expect(l.length).to eq(6)
    end

    it 'should allow for chaining' do
      l = LinkedList.new

      expect(
        l.append_each([1, 2, 3]).append_each([4, 5, 6]).length
      ).to eq(6)

      expect(l.first).to eq(1)
    end
  end

  describe 'first' do
    it 'should return nil if list is empty' do
      expect(LinkedList.new.first).to eq(nil)
    end

    it 'should return the head of the list' do
      l = LinkedList.new
      l.append_each([5, 4, 3, 2, 1])
      expect(l.first).to eq(5)
    end
  end

  describe 'rest' do
    it 'should return nil if list is empty' do
      expect(LinkedList.new.rest).to eq(nil)
    end

    it 'should return empty list if list is length 1' do
      expect(LinkedList.new.cons(1).rest.empty?).to be(true)
    end

    it 'should return an instance of LinkedList' do
      expect(LinkedList.new.cons_each(1..10).rest).to be_an_instance_of(LinkedList)
    end

    it 'should return list of correct length' do
      l = LinkedList.new
      l.cons_each(1..10)
      expect(l.rest.length).to eq(9)
    end

    it 'should return pointer to the same underlying nodes' do
      l = LinkedList.new
      l.cons_each([1, 2, 3])

      r = l.rest.head
      # Reach into the internals a bit
      o = l.head.succ
      expect(r === o).to be(true)
    end
  end

  describe '[]' do
    it 'should raise IndexError on empty list' do
      l = LinkedList.new
      expect { l[0] }.to raise_error(IndexError)
    end

    it 'should raise IndexError with negative index' do
      l = LinkedList.new
      l.cons_each([1, 2, 3])
      expect { l[-1] }.to raise_error(IndexError)
    end

    it 'should raise IndexError on out of bounds' do
      l = LinkedList.new
      l.cons_each([1, 2, 3])
      expect { l[3] }.to raise_error(IndexError)
    end

    it 'should fetch correct item' do
      l = LinkedList.new
      l.append_each([*1..10])
      for i in 0..9
        expect(l[i]).to eq(i + 1)
      end
    end
  end

  describe '[]=' do
    it 'should raise IndexError on empty list' do
      l = LinkedList.new
      expect { l[0] = 42 }.to raise_error(IndexError)
    end

    it 'should raise IndexError with negative index' do
      l = LinkedList.new
      l.cons_each([1, 2, 3])
      expect { l[-1] = 42 }.to raise_error(IndexError)
    end

    it 'should raise IndexError on out of bounds' do
      l = LinkedList.new
      l.cons_each([1, 2, 3])
      expect { l[3] = 42 }.to raise_error(IndexError)
    end

    it 'should correctly set node value' do
      l = LinkedList.new
      l.cons_each([1, 2, 3])
      l[1] = 42
      expect(l[1]).to eq(42)
    end
  end

  describe 'insert' do
    it 'should work on empty lists for index 0' do
      l = LinkedList.new
      l.insert(0, 42)
      expect(l.first).to eq(42)
    end

    it 'should raise exception on empty list for non-0 index' do
      l = LinkedList.new
      expect { l.insert(1, 42) }.to raise_error(IndexError)
    end

    it 'should correctly insert on non-empty list' do
      l = LinkedList.new
      l.append_each([1, 2, 3])

      l.insert(0, 42)

      expect(l.first).to eq(42)

      l.insert(2, 99)

      expect(l[1]).to eq(1)
      expect(l[2]).to eq(99)
      expect(l[3]).to eq(2)
    end

    it 'should correctly insert at end' do
      l = LinkedList.new
      l.append_each([1, 2, 3])

      l.insert(3, 42)
      expect(l[3]).to eq(42)
    end
  end

  describe 'remove_at' do
    it 'should raise error if list is empty' do
      l = LinkedList.new
      expect { l.remove_at(0) }.to raise_error(IndexError)
    end

    it 'should raise error called out of bounds' do
      l = LinkedList.new
      l.cons_each(1..10)
      expect { l.remove_at(100) }.to raise_error(IndexError)
    end

    it 'should return an empty list when called on 1-elem list' do
      l = LinkedList.new
      l.cons(1)

      expect(l.remove_at(0).empty?).to be(true)
    end

    it 'should work on the first element' do
      l = LinkedList.new
      l.cons_each(1..10)

      l.remove_at(0)
      expect(l.length).to eq(9)
      expect(l.first).to eq(9)
    end

    it 'should work on the last element' do
      l = LinkedList.new
      l.cons_each(1..10)

      l.remove_at(9)
      expect(l.length).to eq(9)
      expect(l.first).to eq(10)
    end

    it 'should work on middle elements' do
      l = LinkedList.new
      l.cons_each(1..5)

      l.remove_at(2)
      expect(l.length).to eq(4)
      expect(l[1]).to eq(4)
      expect(l[2]).to eq(2)
    end
  end

  describe 'concat' do
    it 'should work on two empty lists' do
      x = LinkedList.new
      y = LinkedList.new
      expect(x.concat(y).empty?).to be(true)
    end

    it 'should work when the left list is empty' do
      x = LinkedList.new
      y = LinkedList.new.cons_each([1, 2, 3])
      expect(x.concat(y).length).to eq(3)
    end

    it 'should work when the right list is empty' do
      x = LinkedList.new.cons_each([1, 2, 3])
      y = LinkedList.new
      expect(x.concat(y).length).to eq(3)
    end

    it 'should work when neither list is empty' do
      x = LinkedList.new.cons_each([1, 2, 3])
      y = LinkedList.new.cons_each([1, 2, 3])
      expect(x.concat(y).length).to eq(6)
    end
  end

  describe 'split_at' do
    it 'should raise IndexError on empty list' do
      l = LinkedList.new
      expect { l.split_at(0) }.to raise_error(IndexError)
    end

    it 'should raise IndexError when called out of range' do
      l = LinkedList.new.cons_each([1, 2, 3, 4, 5])
      expect { l.split_at(5) }.to raise_error(IndexError)
    end

    it 'should work for length-1 list' do
      l = LinkedList.new.cons(1)
      stuff = l.split_at(0)
      l = stuff[0]
      r = stuff[1]
      expect(l.length).to eq(1)
      expect(r.length).to eq(0)
    end

    it 'should work for normal lists' do
      l = LinkedList.new.cons_each([5, 4, 3, 2, 1])
      stuff = l.split_at(2)
      l = stuff[0]
      r = stuff[1]
      expect(l.length).to eq(3)
      expect(r.length).to eq(2)

      expect(l.first).to eq(1)
      expect(r.first).to eq(4)
    end
  end

  describe 'to_a' do
    it 'works for empty lists' do
      l = LinkedList.new
      expect(l.to_a).to eq([])
    end

    it 'works for other lists' do
      l = LinkedList.new.cons_each([1, 2, 3])
      expect(l.to_a).to eq([3, 2, 1])
    end
  end

  # TODO: Write tests for each, map!, and reduce
  # I've tested them interactively, and `reduce`
  # is used by `to_a`.
end
