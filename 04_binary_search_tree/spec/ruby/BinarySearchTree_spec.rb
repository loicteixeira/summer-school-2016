require "spec_helper"

describe "BinarySearchTree#eql?" do
	it "should return `true` for new trees" do
		t1 = BinarySearchTree.new
		t2 = BinarySearchTree.new
		z = t1.eql?(t2)
		expect(z).to eql(true)
	end

	it "should return `false` for a new tree and a tree with root element" do
		t1 = BinarySearchTree.new
		t2 = BinarySearchTree.root(2)
		z = t1.eql?(t2)
		expect(z).to eql(false)
	end

	it "should return `true` for trees with `eql?` root elements" do
		t1 = BinarySearchTree.root(2)
		t2 = BinarySearchTree.root(2)
		z = t1.eql?(t2)
		expect(z).to eql(true)
	end

	it "should return `false` for trees with not `eql?` root elements" do
		t1 = BinarySearchTree.root(2)
		t2 = BinarySearchTree.root(3)
		z = t1.eql?(t2)
		expect(z).to eql(false)
	end

	it "should return `true` for trees with `eql?` root elements and `eql?` left elements" do
		t1 = BinarySearchTree.root(3) { left(2) }
		t2 = BinarySearchTree.root(3) { left(2) }
		z = t1.eql?(t2)
		expect(z).to eql(true)
	end

	it "should return `false` for trees with `eql?` root elements and not `eql?` left elements" do
		t1 = BinarySearchTree.root(3) { left(2) }
		t2 = BinarySearchTree.root(3) { left(1) }
		z = t1.eql?(t2)
		expect(z).to eql(false)
	end

	it "should return `true` for trees with `eql?` root elements and `eql?` right elements" do
		t1 = BinarySearchTree.root(3) { right(5) }
		t2 = BinarySearchTree.root(3) { right(5) }
		z = t1.eql?(t2)
		expect(z).to eql(true)
	end

	it "should return `false` for trees with `eql?` root elements and not `eql?` right elements" do
		t1 = BinarySearchTree.root(3) { right(5) }
		t2 = BinarySearchTree.root(3) { right(7) }
		z = t1.eql?(t2)
		expect(z).to eql(false)
	end
end

describe "BinarySearchTree#add" do
	it "should add element as root node" do
		t = BinarySearchTree.new
		t.add(3)
		expect(t).to eql(BinarySearchTree.root(3))
	end

	it "should add element as left node" do
		t = BinarySearchTree.root(3)
		t.add(2)
		expect(t).to eql(BinarySearchTree.root(3) { left(2) })
	end

	it "should add element as right node" do
		t = BinarySearchTree.root(3)
		t.add(5)
		expect(t).to eql(BinarySearchTree.root(3) { right(5) })
	end
end

describe "BinarySearchTree::Util#replace" do
	it "should replace for node with no left node" do
		deleted_node = BinarySearchTree::Node.new(2) { right(3) }
		node = BinarySearchTree::Util.replace(deleted_node)
		expect(node).to eql(BinarySearchTree::Node.new(3))
	end

	it "should replace for node with left node with no right node" do
		deleted_node = BinarySearchTree::Node.new(3) {
			left(2) { left(1) }
			right(5)
		}
		node = BinarySearchTree::Util.replace(deleted_node)
		expect(node).to eql(BinarySearchTree::Node.new(2) {
			left(1)
			right(5)
		})
	end

	it "should replace for node with left node with right node" do
		deleted_node = BinarySearchTree::Node.new(5) {
			left(1) { right(3) { left(2) } }
			right(7)
		}
		node = BinarySearchTree::Util.replace(deleted_node)
		expect(node).to eql(BinarySearchTree::Node.new(3) {
			left(1) { right(2) }
			right(7)
		})
	end

	it "should replace for node with left node with right node with right node" do
		deleted_node = BinarySearchTree::Node.new(5) {
			left(1) { right(2) { right(4) { left(3) } } }
			right(7)
		}
		node = BinarySearchTree::Util.replace(deleted_node)
		expect(node).to eql(BinarySearchTree::Node.new(4) {
			left(1) { right(2) { right(3) } }
			right(7)
		})
	end
end

describe "BinarySearchTree#delete" do
	it "should remove root node" do
		t = BinarySearchTree.root(3)
		t.delete(3)
		expect(t).to eql(BinarySearchTree.new)
	end

	it "should remove left node" do
		t = BinarySearchTree.root(3) { left(2) }
		t.delete(2)
		expect(t).to eql(BinarySearchTree.root(3))
	end

	it "should remove right node" do
		t = BinarySearchTree.root(3) { right(5) }
		t.delete(5)
		expect(t).to eql(BinarySearchTree.root(3))
	end
end

describe "BinarySearchTree#member?" do
	it "should return `false` for new tree" do
		t = BinarySearchTree.new
		z = t.member?(3)
		expect(z).to eql(false)
	end

	it "should return `true` for element in root node" do
		t = BinarySearchTree.root(3)
		z = t.member?(3)
		expect(z).to eql(true)
	end

	it "should return `true` for element in left node" do
		t = BinarySearchTree.root(3) { left(2) }
		z = t.member?(2)
		expect(z).to eql(true)
	end

	it "should return `true` for element in right node" do
		t = BinarySearchTree.root(3) { right(5) }
		z = t.member?(5)
		expect(z).to eql(true)
	end

	it "should return `false` for element not in tree" do
		t = BinarySearchTree.root(3) {
			left(2)
			right(5)
		}
		z = t.member?(7)
		expect(z).to eql(false)
	end
end
