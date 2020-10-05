class Node
  attr_accessor :value, :right_child, :left_child
  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
  end
end

class Tree
  attr_accessor :root
  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.length / 2
    root = Node.new(arr[mid])

    root.left_child = build_tree(arr.slice(0, arr.length / 2))
    root.right_child = build_tree(arr.slice(arr.length / 2 + 1, arr.length - 1))

    root
  end

  def insert(root = @root, value)
    return Node.new(value) if root.nil?

    if value > root.value
      root.right_child = insert(root.right_child, value)
    elsif value < root.value
      root.left_child = insert(root.left_child, value)
    else return root
    end
    root
  end

  def delete(root = @root, value)
    return root if root.nil?

    if value < root.value
      root.left_child = delete(root.left_child, value)
    elsif value > root.value
      root.right_child = delete(root.right_child, value)
    else
      if root.left_child.nil?
        temp = root.right_child
        root.nil?
        return temp
      elsif root.right_child.nil?
        temp = root.left_child
        root.nil?
        return temp
      end

      temp = find_min_node(root.right_child)

      root.value = temp.value

      root.right_child = delete(root.right_child, temp.value)

    end
    root
  end

  def find(value)
    find_node(value).value
  end

  def level_order
    return [] if @root.nil?

    queue = [@root]
    arr = []

    until queue.empty?
      temp = queue.shift
      arr << temp.value
      queue << temp.left_child unless temp.left_child.nil?
      queue << temp.right_child unless temp.right_child.nil?
    end

    arr
  end

  def preorder(arr = [], root = @root)
    arr.push(root.value)
    preorder(arr, root.left_child) unless root.left_child.nil?
    preorder(arr, root.right_child) unless root.right_child.nil?
    arr
  end

  def in_order(arr = [], root = @root)
    in_order(arr, root.left_child) unless root.left_child.nil?
    arr.push(root.value)
    in_order(arr, root.right_child) unless root.right_child.nil?
    arr
  end

  def post_order(arr = [], root = @root)
    post_order(arr, root.left_child) unless root.left_child.nil?
    post_order(arr, root.right_child) unless root.right_child.nil?
    arr.push(root.value)
    arr
  end

  def height(value = @root.value)
    tree_height(find_node(value))
  end

  def balanced?
    return true if (tree_height(@root.left_child) - tree_height(@root.right_child)).abs <= 1
  end

  def rebalance
    @root = build_tree(level_order.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  private

  def find_min_node(node)
    current = node
    current = current.left_child until current.left_child.nil?
    current
  end

  def tree_height(node = @root)
    return -1 if node.nil?

    left_height = tree_height(node.left_child)
    right_height = tree_height(node.right_child)

    left_height >= right_height ? left_height + 1 : right_height + 1
  end

  def find_node(root = @root, value)
    return root if root.value == value

    value > root.value ? find_node(root.right_child, value) : find_node(root.left_child, value)
  end
end

my_bst = Tree.new([1, 4, 5, 7, 8, 11, 13])
my_bst.insert(10)
my_bst.insert(100)
my_bst.insert(140)
my_bst.insert(150)
puts my_bst.pretty_print

my_bst.rebalance

puts my_bst.pretty_print
