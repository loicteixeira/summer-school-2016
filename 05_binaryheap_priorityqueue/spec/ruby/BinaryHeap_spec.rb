require "spec_helper"

describe "BinaryHeap#first" do
	it "should return `nil` for heap with no elements" do
		h = BinaryHeap[]
		e = h.first
		expect(e).to eql(nil)
	end

	it "should return first element for heap with one element" do
		h = BinaryHeap[2]
		e = h.first
		expect(e).to eql(2)
	end
end

describe "BinaryHeap::Util.sift_up" do
	it "should move no elements for larger element" do
		m = Memory[2, nil, nil]
		e = 3
		i = BinaryHeap::Util.sift_up(m, 1, e)
		m[i] = e
		expect(m).to eql(Memory[2, 3, nil])
		expect(i).to eql(1)
	end

	it "should move one element for smaller element" do
		m = Memory[3, nil, nil]
		e = 2
		i = BinaryHeap::Util.sift_up(m, 1, e)
		m[i] = e
		expect(m).to eql(Memory[2, 3, nil])
		expect(i).to eql(0)
	end
end

describe "BinaryHeap::Util.sift_down" do
	it "should move no elements for smaller element" do
		m = Memory[nil, 3, 5, nil, nil, nil, nil]
		e = 2
		i = BinaryHeap::Util.sift_down(m, 3, 0, e)
		m[i] = e
		expect(m).to eql(Memory[2, 3, 5, nil, nil, nil, nil])
		expect(i).to eql(0)
	end

	it "should move one element for larger element" do
		m = Memory[nil, 3, 5, nil, nil, nil, nil]
		e = 7
		i = BinaryHeap::Util.sift_down(m, 3, 0, e)
		m[i] = e
		expect(m).to eql(Memory[3, 7, 5, nil, nil, nil, nil])
		expect(i).to eql(1)
	end
end

describe "BinaryHeap::Util.sift_down_full" do
	it "should move smaller element" do
		m = Memory[nil, 3, 5]
		i = BinaryHeap::Util.sift_down_full(m, 3)
		m[i] = nil
		expect(m).to eql(Memory[3, nil, 5])
		expect(i).to eql(1)
	end
end

describe "BinaryHeap#add" do
	it "should add element to heap" do
		h = BinaryHeap.new(1)
		h.add(2)
		expect(h).to eql(BinaryHeap[2])
	end

	it "should add two elements to heap" do
		h = BinaryHeap.new(3)
		h.add(3)
		h.add(2)
		expect(h).to eql(BinaryHeap[2, 3])
	end

	it "should add three elements to heap" do
		h = BinaryHeap.new(3)
		h.add(5)
		h.add(3)
		h.add(2)
		expect(h).to eql(BinaryHeap[2, 5, 3])
	end

	it "should add four elements to heap" do
		h = BinaryHeap.new(7)
		h.add(7)
		h.add(5)
		h.add(3)
		h.add(2)
		expect(h).to eql(BinaryHeap[2, 3, 5, 7])
	end
end

describe "BinaryHeap#shift" do
	it "should return `nil` for heap with no elements" do
		h = BinaryHeap[]
		e = h.shift
		expect(e).to eql(nil)
	end

	it "should remove and return first element for heap with one element" do
		h = BinaryHeap[2]
		e = h.shift
		expect(h).to eql(BinaryHeap[])
		expect(e).to eql(2)
	end

	it "should remove and return first element for heap with two elements" do
		h = BinaryHeap[2, 3]
		e = h.shift
		expect(h).to eql(BinaryHeap[3])
		expect(e).to eql(2)
	end

	it "should remove and return first element for heap with three elements" do
		h = BinaryHeap[2, 3, 5]
		e = h.shift
		expect(h).to eql(BinaryHeap[3, 5])
		expect(e).to eql(2)
	end

	it "should remove and return first element for heap with four elements" do
		h = BinaryHeap[2, 3, 5, 7]
		e = h.shift
		expect(h).to eql(BinaryHeap[3, 7, 5])
		expect(e).to eql(2)
	end
end
