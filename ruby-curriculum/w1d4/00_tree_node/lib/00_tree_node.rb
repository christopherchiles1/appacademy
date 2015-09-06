class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    # if new_parent is nil, remove self from parent node
    parent.children.delete(self) unless parent.nil?
    unless new_parent.nil?
      new_parent.children << self
    end
    @parent = new_parent
  end

  def remove_child(child)
    raise "No such child" unless children.include?(child)
    child.parent=(nil)
  end

  def add_child(child)
    child.parent=(self)
  end

  def dfs(target_value)
    if value == target_value
      self
    elsif children.empty?
      nil
    else
      children.find_first_truthy { |child| child.dfs(target_value) }
    end
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      current = queue.shift
      return current if current.value == target_value
      queue += current.children
    end
  end

  def trace_path_back
    path = []
    current_node = self
    until current_node.nil?
      path << current_node
      current_node = current_node.parent
    end
    path
  end

  def ==(other_node)
    value == other_node.value
  end
end

module Enumerable
  def find_first_truthy(&blk)
    self.each do |el|
      result = blk.call(el)
      return result if result
    end
    nil
  end
end
