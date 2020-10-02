class Node
  attr_accessor :value, :right_child, :left_child
  def initialize(value)
    @value = value
    @right_child = nil
    @left_child = nil
  end
end

class Tree
    attr_accessor :root
  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
    return nil if arr.last  == nil
    mid = arr.length/2
    root = Node.new(arr[mid])

    root.left_child = build_tree(arr.slice(0, arr.length/2))
    root.right_child = build_tree(arr.slice(arr.length/2, arr.length-1))

    return root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end


  my_bst = Tree.new([1, 2, 3, 4, 5, 6, 7])

  my_bst.pretty_print