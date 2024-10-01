class Node
  attr_accessor :data, :succ

  def initialize(data, succ)
    @data = data
    @succ = succ
  end
end

class LinkedList
  attr_accessor :head

  def initialize(head: nil)
    @head = head
  end

  def cons(value)
    node = Node.new(value, nil)
    node.succ = @head
    @head = node
    self
  end

  def cons_each(values)
    values.each { |v| cons(v) }
    self
  end

  def append(value)
    # If the list is empty, append and cons have the same effect
    return cons(value) if empty?

    # Traverse to the end
    curr = @head
    curr = curr.succ until curr.succ.nil?
    # Attach the new node
    node = Node.new(value, nil)
    curr.succ = node
    self
  end

  def append_each(values)
    # O(N + M) given N=`self.length` and M=`values.length`
    return cons_each(values.reverse) if empty?

    sublist = nil
    values.reverse_each do |v|
      node = Node.new(v, sublist)
      sublist = node
    end

    curr = @head
    curr = curr.succ until curr.succ.nil?
    curr.succ = sublist
    self
  end

  def first
    return nil if @head.nil?

    @head.data
  end

  def rest
    return nil if @head.nil?

    # I don't like this allocation but I don't see a way around it
    LinkedList.new(head: @head.succ)
  end

  def [](idx)
    node = node_at(idx)
    node.data
  end

  alias at :"[]"

  def []=(idx, value)
    node = node_at(idx)
    node.data = value
  end

  def insert(idx, value)
    if idx == 0
      cons(value)
    else
      before_insert = node_at(idx - 1)
      after_insert = before_insert.succ

      new_node = Node.new(value, after_insert)
      before_insert.succ = new_node
    end
    self
  end

  def remove_at(idx)
    # Case 1: 0 elements
    raise IndexError.new "Index #{idx} out of bounds" if empty?

    # Case 2: 1 element
    # `rest` returns nil if @head is nil, but that would be invalid for this method which
    # is why we have the check for `empty?` up top.
    if idx == 0
      @head = @head.succ
      return self
    end

    # Case 3: 2 or more elements
    # Technically this will give a misleading error if we try to remove some far off index.
    # But the alternative is two linear scans instead of 1 scan and an attr read
    pred = node_at(idx - 1)
    to_remove = pred.succ
    # pred is the last element, meaning `idx` was out of bounds to begin with
    raise IndexError.new "Index #{idx} out of bounds" if to_remove.nil?

    after_remove = to_remove.succ
    pred.succ = after_remove
    # Attempt to help the garbage collector
    to_remove = nil
    self
  end

  def concat(other)
    # This feels like a dubious choice
    return other if empty?

    curr = @head
    curr = curr.succ until curr.succ.nil?

    curr.succ = other.head
    self
  end

  def split_at(idx)
    last_of_left = node_at(idx)

    right_list = LinkedList.new(head: last_of_left.succ)
    last_of_left.succ = nil

    [self, right_list]
  end

  def to_a
    reduce([]) { |acc, v| acc << v }
  end

  def empty?
    @head.nil?
  end

  def length
    l = 0
    return l if empty?

    curr = @head
    until curr.nil?
      l += 1
      curr = curr.succ
    end
    l
  end

  alias count length
  alias size length

  def each(&f)
    curr = @head
    f.call(curr.data) until curr.nil?
  end

  def map!(&f)
    curr = @head
    until curr.nil?
      curr.data = f.call(curr.data)
      curr = curr.succ
    end
    self
  end

  def reduce(init, &f)
    acc = init
    curr = @head
    until curr.nil?
      acc = f.call(acc, curr.data)
      curr = curr.succ
    end
    acc
  end

  private

  def node_at(idx)
    raise IndexError.new "Index #{idx} out of bounds" if empty?
    raise IndexError.new "Invalid index #{idx}" if idx < 0

    count = idx
    curr = @head
    until count == 0 || curr.nil?
      curr = curr.succ
      count -= 1
    end
    raise IndexError.new "Index #{idx} out of bounds" if curr.nil?

    curr
  end
end
