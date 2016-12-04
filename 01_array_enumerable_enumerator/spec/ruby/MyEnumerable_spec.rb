require "spec_helper"

describe "MyEnumerable#all?" do
	it "should return `true` for array of no elements" do
		a = MyArray[].checkcast("MyArray<Integer>")
		z = a.all? { |e| e.odd? }
		expect(z).to eql(true)
	end

	it "should return `false` unless all elements satisfy the block for array of two elements" do
		a = MyArray[2, 3]
		n = a.all? { |e| e.odd? }
		expect(n).to eql(false)
	end

	it "should return `true` if all elements satisfy the block for array of two elements" do
		a = MyArray[3, 5]
		n = a.all? { |e| e.odd? }
		expect(n).to eql(true)
	end
end

describe "MyEnumerable#any?" do
	it "should return `false` for array of no elements" do
		a = MyArray[].checkcast("MyArray<Integer>")
		z = a.any? { |e| e.odd? }
		expect(z).to eql(false)
	end

	it "should return `true` if any elements satisfy the block for array of two elements" do
		a = MyArray[2, 3]
		z = a.any? { |e| e.odd? }
		expect(z).to eql(true)
	end

	it "should return `false` unless any elements satisfy the block for array of two elements" do
		a = MyArray[2, 4]
		z = a.any? { |e| e.odd? }
		expect(z).to eql(false)
	end
end

describe "MyEnumerable#count" do
	it "should return `0` for array of no elements" do
		a = MyArray[].checkcast("MyArray<Integer>")
		n = a.count { |e| e.odd? }
		expect(n).to eql(0)
	end

	it "should return how many elements satisfy the block for array of two elements" do
		a = MyArray[2, 3]
		n = a.count { |e| e.odd? }
		expect(n).to eql(1)
	end
end

describe "MyEnumerable#find" do
	it "should return `nil` for array of no elements" do
		a = MyArray[].checkcast("MyArray<Integer>")
		e = a.find { |e| e.odd? }
		expect(e).to eql(nil)
	end

	it "should return `nil` for array of no satisfying elements" do
		a = MyArray[2]
		e = a.find { |e| e.odd? }
		expect(e).to eql(nil)
	end

	it "should return first satisfying element for array of two satisfying elements" do
		a = MyArray[2, 3]
		e = a.find { |e| e.odd? }
		expect(e).to eql(3)
	end
end

describe "MyEnumerable#find_index" do
	it "should return `nil` for array of no elements" do
		a = MyArray[].checkcast("MyArray<Integer>")
		i = a.find_index { |e| e.odd? }
		expect(i).to eql(nil)
	end

	it "should return `nil` for array of no satisfying elements" do
		a = MyArray[2]
		i = a.find_index { |e| e.odd? }
		expect(i).to eql(nil)
	end

	it "should return index of first satisfying element for array of two satisfying elements" do
		a = MyArray[2, 3, 5]
		i = a.find_index { |e| e.odd? }
		expect(i).to eql(1)
	end
end

describe "MyEnumerable#first" do
	it "should return `nil` for array of no elements" do
		a = MyArray[]
		e = a.first
		expect(e).to eql(nil)
	end

	it "should return first element for array of two elements" do
		a = MyArray[2, 3]
		e = a.first
		expect(e).to eql(2)
	end
end

describe "MyEnumerable#map" do
	it "should return empty array for array of no elements" do
		a1 = MyArray[].checkcast("MyArray<Integer>")
		a2 = a1.map { |e| e.odd? }
		expect(a2).to eql(MyArray[])
	end

	it "should return array of two mapped elements for array of two elements" do
		a1 = MyArray[2, 3]
		a2 = a1.map { |e| e.odd? }
		expect(a2).to eql(MyArray[false, true])
	end
end

describe "MyEnumerable#reject" do
	it "should return empty array for array of no elements" do
		a1 = MyArray[].checkcast("MyArray<Integer>")
		a2 = a1.reject { |e| e.odd? }
		expect(a2).to eql(MyArray[])
	end

	it "should return array of non-satisfying elements for array of two elements" do
		a1 = MyArray[2, 3]
		a2 = a1.reject { |e| e.odd? }
		expect(a2).to eql(MyArray[2])
	end
end

describe "MyEnumerable#select" do
	it "should return empty array for array of no elements" do
		a1 = MyArray[].checkcast("MyArray<Integer>")
		a2 = a1.select { |e| e.odd? }
		expect(a2).to eql(MyArray[])
	end

	it "should return array of satisfying elements for array of two elements" do
		a1 = MyArray[2, 3]
		a2 = a1.select { |e| e.odd? }
		expect(a2).to eql(MyArray[3])
	end
end
