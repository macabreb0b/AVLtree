class Node
  attr_accessor :value, :parent
  attr_reader :left, :right
  
  def self.left_rotation(node)
    high_node = node
    low_node = node.right
    
    high_node.right = low_node.left
    low_node.parent = high_node.parent
    low_node.left = high_node
  end
  
  def self.right_rotation(node)
    high_node = node
    low_node = node.left
    
    high_node.left = low_node.right
    low_node.parent = high_node.parent
    low_node.right = high_node
  end
  
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
    if self.balance == 2
      if left.balance == -1
        Node.left_rotation(left)
      end
      
      Node.right_rotation(self)
    else
      if right.balance == 1
        Node.right_rotation(right)
      end
      
      Node.left_rotation(self)
    end
  end  
end