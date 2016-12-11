require "spec_helper"

describe "DoublyLinkedList#eql?" do
	it "should return `true` for new list and list of no elements" do
		l1 = DoublyLinkedList.new
		l2 = DoublyLinkedList[]
		z = l1.eql?(l2)
		expect(z).to eql(true)
	end

	it "should return `false` for new list and list of one `nil` element" do
		l1 = DoublyLinkedList.new
		l2 = DoublyLinkedList[nil]
		z = l1.eql?(l2)
		expect(z).to eql(false)
	end

	it "should return `true` for lists of `eql?` elements" do
		l1 = DoublyLinkedList[3, 5]
		l2 = DoublyLinkedList[3, 5]
		z = l1.eql?(l2)
		expect(z).to eql(true)
	end

	it "should return `false` for lists with different sizes" do
		l1 = DoublyLinkedList[3]
		l2 = DoublyLinkedList[3, 5]
		z = l1.eql?(l2)
		expect(z).to eql(false)
	end

	it "should return `false` for lists of not `eql?` elements" do
		l1 = DoublyLinkedList[3, 5]
		l2 = DoublyLinkedList[5, 3]
		z = l1.eql?(l2)
		expect(z).to eql(false)
	end
end

describe "DoublyLinkedList#each" do
	it "should not yield for new list" do
		l = DoublyLinkedList.new
		expect { |b|
			l.each(&b)
		}.not_to yield_control
	end

	it "should not yield for list of no elements" do
		l = DoublyLinkedList[]
		expect { |b|
			l.each(&b)
		}.not_to yield_control
	end

	it "should yield each element for list of two elements" do
		l = DoublyLinkedList[3, 5]
		expect { |b|
			l.each(&b)
		}.to yield_successive_args(3, 5)
	end
end

describe "DoublyLinkedList#size" do
	it "should return `0` for new list" do
		l = DoublyLinkedList.new
		n = l.size
		expect(n).to eql(0)
	end

	it "should return `0` for list of no elements" do
		l = DoublyLinkedList[]
		n = l.size
		expect(n).to eql(0)
	end

	it "should return `1` for list of one element" do
		l = DoublyLinkedList[2]
		n = l.size
		expect(n).to eql(1)
	end
end

describe "DoublyLinkedList#empty?" do
	it "should return `true` for new list" do
		l = DoublyLinkedList.new
		z = l.empty?
		expect(z).to eql(true)
	end

	it "should return `true` for list of no elements" do
		l = DoublyLinkedList[]
		z = l.empty?
		expect(z).to eql(true)
	end

	it "should return `false` for list of one element" do
		l = DoublyLinkedList[2]
		z = l.empty?
		expect(z).to eql(false)
	end
end

describe "DoublyLinkedList#pop" do
	it "should return `nil` for new list" do
		l = DoublyLinkedList.new
		e = l.pop
		expect(e).to eql(nil)
	end

	it "should return `nil` for list of no elements" do
		l = DoublyLinkedList[]
		e = l.pop
		expect(e).to eql(nil)
	end

	it "should remove and return last element for list of two elements" do
		l = DoublyLinkedList[3, 5]
		e = l.pop
		expect(l).to eql(DoublyLinkedList[3])
		expect(e).to eql(5)
	end
end

describe "DoublyLinkedList#push" do
	it "should append one element to new list" do
		l = DoublyLinkedList.new
		l.push(3)
		expect(l).to eql(DoublyLinkedList[3])
	end

	it "should append two elements to new list" do
		l = DoublyLinkedList.new
		l.push(3)
		l.push(5)
		expect(l).to eql(DoublyLinkedList[3, 5])
	end

	it "should append element to list of two elements" do
		l = DoublyLinkedList[3, 5]
		l.push(7)
		expect(l).to eql(DoublyLinkedList[3, 5, 7])
	end
end

describe "DoublyLinkedList#shift" do
	it "should return `nil` for new list" do
		l = DoublyLinkedList.new
		e = l.shift
		expect(e).to eql(nil)
	end

	it "should return `nil` for list of no elements" do
		l = DoublyLinkedList[]
		e = l.shift
		expect(e).to eql(nil)
	end

	it "should remove and return first element for list of two elements" do
		l = DoublyLinkedList[3, 5]
		e = l.shift
		expect(l).to eql(DoublyLinkedList[5])
		expect(e).to eql(3)
	end
end

describe "DoublyLinkedList#unshift" do
	it "should prepend one element to new list" do
		l = DoublyLinkedList.new
		l.unshift(3)
		expect(l).to eql(DoublyLinkedList[3])
	end

	it "should prepend two elements to new list" do
		l = DoublyLinkedList.new
		l.unshift(3)
		l.unshift(5)
		expect(l).to eql(DoublyLinkedList[5, 3])
	end

	it "should prepend element to list of two elements" do
		l = DoublyLinkedList[3, 5]
		l.unshift(7)
		expect(l).to eql(DoublyLinkedList[7, 3, 5])
	end
end
