require "spec_helper"

describe "SinglyLinkedList#eql?" do
	it "should return `true` for new list and list of no elements" do
		l1 = SinglyLinkedList.new
		l2 = SinglyLinkedList[]
		z = l1.eql?(l2)
		expect(z).to eql(true)
	end

	it "should return `false` for new list and list of one `nil` element" do
		l1 = SinglyLinkedList.new
		l2 = SinglyLinkedList[nil]
		z = l1.eql?(l2)
		expect(z).to eql(false)
	end

	it "should return `true` for lists of `eql?` elements" do
		l1 = SinglyLinkedList[3, 5]
		l2 = SinglyLinkedList[3, 5]
		z = l1.eql?(l2)
		expect(z).to eql(true)
	end

	it "should return `false` for lists with different sizes" do
		l1 = SinglyLinkedList[3]
		l2 = SinglyLinkedList[3, 5]
		z = l1.eql?(l2)
		expect(z).to eql(false)
	end

	it "should return `false` for lists of not `eql?` elements" do
		l1 = SinglyLinkedList[3, 5]
		l2 = SinglyLinkedList[5, 3]
		z = l1.eql?(l2)
		expect(z).to eql(false)
	end
end

describe "SinglyLinkedList#each" do
	it "should not yield for new list" do
		l = SinglyLinkedList.new
		expect { |b|
			l.each(&b)
		}.not_to yield_control
	end

	it "should not yield for list of no elements" do
		l = SinglyLinkedList[]
		expect { |b|
			l.each(&b)
		}.not_to yield_control
	end

	it "should yield each element for list of two elements" do
		l = SinglyLinkedList[3, 5]
		expect { |b|
			l.each(&b)
		}.to yield_successive_args(3, 5)
	end
end

describe "SinglyLinkedList#size" do
	it "should return `0` for new list" do
		l = SinglyLinkedList.new
		n = l.size
		expect(n).to eql(0)
	end

	it "should return `0` for list of no elements" do
		l = SinglyLinkedList[]
		n = l.size
		expect(n).to eql(0)
	end

	it "should return `1` for list of one element" do
		l = SinglyLinkedList[2]
		n = l.size
		expect(n).to eql(1)
	end
end

describe "SinglyLinkedList#empty?" do
	it "should return `true` for new list" do
		l = SinglyLinkedList.new
		z = l.empty?
		expect(z).to eql(true)
	end

	it "should return `true` for list of no elements" do
		l = SinglyLinkedList[]
		z = l.empty?
		expect(z).to eql(true)
	end

	it "should return `false` for list of one element" do
		l = SinglyLinkedList[2]
		z = l.empty?
		expect(z).to eql(false)
	end
end

describe "SinglyLinkedList#shift" do
	it "should return `nil` for new list" do
		l = SinglyLinkedList.new
		e = l.shift
		expect(e).to eql(nil)
	end

	it "should return `nil` for list of no elements" do
		l = SinglyLinkedList[]
		e = l.shift
		expect(e).to eql(nil)
	end

	it "should remove and return first element for list of two elements" do
		l = SinglyLinkedList[3, 5]
		e = l.shift
		expect(l).to eql(SinglyLinkedList[5])
		expect(e).to eql(3)
	end
end

describe "SinglyLinkedList#unshift" do
	it "should prepend one element to new list" do
		l = SinglyLinkedList.new
		l.unshift(3)
		expect(l).to eql(SinglyLinkedList[3])
	end

	it "should prepend two elements to new list" do
		l = SinglyLinkedList.new
		l.unshift(3)
		l.unshift(5)
		expect(l).to eql(SinglyLinkedList[5, 3])
	end

	it "should prepend element to list of two elements" do
		l = SinglyLinkedList[3, 5]
		l.unshift(7)
		expect(l).to eql(SinglyLinkedList[7, 3, 5])
	end
end
