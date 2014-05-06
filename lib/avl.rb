class Node
  attr_accessor :value, :parent
  attr_reader :left, :right
  
  def initialize(value)
    @parent = nil
    @value = value
  end
  
  def right=(node)
    @right = node
    @right.parent = self
  end
  
  def left=(node)
    @left = node
    @left.parent = self
  end
  
  def balance
    left_depth = (self.left.nil? ? 0 : self.left.depth)
    right_depth = (self.right.nil? ? 0 : self.right.depth)
    
    right_depth - left_depth
  end
  
  def depth
    left_depth = (self.left.nil? ? 0 : self.left.depth)
    right_depth = (self.right.nil? ? 0 : self.right.depth)
    
    1 + [left_depth, right_depth].max
  end
  
  def insert(node)
    if node.value > self.value
      if self.right.nil? 
        self.right = node 
        self.check_balance!
      else 
        self.right.insert(node)
      end
    else
      if self.left.nil?
        self.left = node
        self.check_balance!
      else
        self.left.insert(node)
      end
    end
  end
  
  def include?(num)
    return true if num == self.value
    if num > self.value
      !!self.right && self.right.include?(num)
    else
      !!self.left && self.left.include?(num)
    end
  end
  
  def check_balance!
    old_depth = self.depth
    
    if self.balance.abs > 1
      self.rotate!
    end
    
    if old_depth != self.depth
      !self.parent || self.parent.check_balance!
    end
  end
  
  def rotate!
    # check which case, and call rotations on appropriate nodes:
    # -2, 0 => left rotation
    # -2, -1 => left rotation
    # -2, 1, 0 => 
    # -2, 1, 1 => 
    # -2, 1, -1 => 
    
    # 2, 0 => right rotation
    # 2, -1 => right rotation
    # 2, 1, 0 => 
    # 2, 1, 1 => 
    # 2, 1, -1 => 
  end
  
  def self.left_rotation(low_node, high_node)
    high_node.right = low_node.left
    low_node.parent = high_node.parent
    low_node.left = high_node
  end
  
  def self.right_rotation(low_node, high_node)
    high_node.left = low_node.right
    low_node.parent = high_node.parent
    low_node.right = high_node
  end
end