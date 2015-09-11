class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
  end

  def empty?
    @head.nil?
  end

  def get(key)
    found_link = find { |link| link.key == key }
    found_link ? found_link.val : nil
  end

  def include?(key)
    any? { |link| link.key == key }
  end

  def insert(key, val)
    link = @head
    until link.next.nil?
      link = link.next
    end
    link.next = Link.new(key, val, nil)
  end

  def remove(key)
    link = @head
    end_of_list = link.next.nil?

    until end_of_list || link.next.key == key
      link = link.next
    end

    return nil if end_of_list
    link.next = link.next.next
  end

  def each(&prc)
    prc ||= Proc.new {}
    link = first
    until link.nil?
      prc.call(link)
      link = link.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
