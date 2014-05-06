require 'rspec'
require 'avl'

describe "AVL node" do
  let(:root) { Node.new(7) }
  
  it "knows its own balance" do
    expect(root.balance).to eq(0)
  end
  
  it "knows its own depth" do
    expect(root.depth).to eq(1)
  end
  
  it "stores its integer value as an instance variable" do
    expect(root.value).to eq(7)
  end
  
  it "can access its left and right children" do
    root.insert(Node.new(8))
    root.insert(Node.new(4))
    
    expect(root.left.value).to eq(4)
    expect(root.right.value).to eq(8)
  end
  
  describe "#include?" do
    before(:each) do 
      root.insert(Node.new(8))
      root.insert(Node.new(4))
    end
    
    it "returns true for a value that's included" do
      expect(root.include?(4)).to be true
    end
    
    it "returns false for a value that's not included" do
      expect(root.include?(5)).to be false
    end
  end
  
  describe "#insert" do
    before(:each) do
      root.insert(Node.new(8))
      root.insert(Node.new(9))
      root.insert(Node.new(10))
      root.insert(Node.new(2))
    end
    
    it "inserts higher numbers to the right" do
      expect(root.right.right.right.value).to eq(10)
    end
    
    it "inserts lower numbers to the left" do
      expect(root.left.value).to eq(2)
    end

    it "sets the parent of child nodes" do
      expect(root.left.parent.value).to eq(7)
    end
  end
  
  describe "#depth" do
    context "with no children" do
      it "returns 1" do
        expect(root.depth).to eq(1)
      end
    end
    
    context "with multiple children" do
      before(:each) do
        root.insert(Node.new(8))
        root.insert(Node.new(9))
        root.insert(Node.new(10))
        root.insert(Node.new(2))
      end
      
      it "returns 4 for the root node" do
        expect(root.depth).to eq(4)
      end
      
      it "returns 2 for the third right node" do
        expect(root.right.right.depth).to eq(2)
      end
      
      it "returns 1 for the lonely left node without children" do
        expect(root.left.depth).to eq(1)
      end
    end
  end
  
  describe "#balance" do
    it "returns 0 with no children" do
      expect(root.balance).to eq(0)
    end

    it "returns +1 with one right child" do
      root.insert(Node.new(10))
      expect(root.balance).to eq(1)
    end

    it "returns -1 with one left child" do
      root.insert(Node.new(4))
      expect(root.balance).to eq(-1)
    end
  end
  
  describe "#check_balance" do
    it "calls #rotate if absolute value of balance is over 1" do
      root.insert(Node.new(4))
      root.insert(Node.new(3))
      
      expect(root).to receive(:rotate!)
      root.check_balance!
    end
    
    it "does not call #rotate if absolute value of balance is 1 or below" do
      root.insert(Node.new(4))
      root.insert(Node.new(8))
      
      expect(root).to_not receive(:rotate!)
      root.check_balance!
    end
  end
end