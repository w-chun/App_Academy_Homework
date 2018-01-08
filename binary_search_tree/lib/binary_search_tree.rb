# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative "bst_node"

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if root.nil?
      @root = BSTNode.new(value)
    else
      insert_node(@root, value)
    end
  end

  def find(value, tree_node = @root)
    return nil unless tree_node
    if value == tree_node.value
      tree_node
    elsif value < tree_node.value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    node = find(value)
    return nil unless node

    if @root == node
      return @root = nil
    else
      node.parent.left = nil if node.parent.left == node
      node.parent.right = nil if node.parent.right == node
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node unless tree_node.right
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return 0 unless tree_node && (tree_node.left || tree_node.right)
    1 + [depth(tree_node.left), depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    depth(tree_node.left) - depth(tree_node.right) == 0
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end


  private
  # optional helper methods go here:
  def insert_node(parent=@root, value)
    if parent.value < value
      if parent.right.nil?
        parent.right = BSTNode.new(value, parent)
      else
        insert_node(parent.right, value)
      end
    else
      if parent.left.nil?
        parent.left = BSTNode.new(value, parent)
      else
        insert_node(parent.left, value)
      end
    end
  end
end
