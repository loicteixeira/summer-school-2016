require "spec_helper"

describe "MyArray#eql?" do
	it "should return `true` for new array and array of no elements" do
		a1 = MyArray.new
		a2 = MyArray[]
		z = a1.eql?(a2)
		expect(z).to eql(true)
	end

	it "should return `false` for new array and array of one `nil` element" do
		a1 = MyArray.new
		a2 = MyArray[nil]
		z = a1.eql?(a2)
		expect(z).to eql(false)
	end

	it "should return `true` for arrays of `eql?` elements" do
		a1 = MyArray[3, 5]
		a2 = MyArray[3, 5]
		z = a1.eql?(a2)
		expect(z).to eql(true)
	end

	it "should return `false` for arrays with different sizes" do
		a1 = MyArray[3]
		a2 = MyArray[3, 5]
		z = a1.eql?(a2)
		expect(z).to eql(false)
	end

	it "should return `false` for arrays of not `eql?` elements" do
		a1 = MyArray[3, 5]
		a2 = MyArray[5, 3]
		z = a1.eql?(a2)
		expect(z).to eql(false)
	end
end

describe "MyArray#each" do
	it "should not yield for new array" do
		a = MyArray.new
		expect { |b|
			a.each(&b)
		}.not_to yield_control
	end

	it "should not yield for array of no elements" do
		a = MyArray[]
		expect { |b|
			a.each(&b)
		}.not_to yield_control
	end

	it "should yield each element for array of two elements" do
		a = MyArray[3, 5]
		expect { |b|
			a.each(&b)
		}.to yield_successive_args(3, 5)
	end
end

describe "MyArray#size" do
	it "should return `0` for new array" do
		a = MyArray.new
		n = a.size
		expect(n).to eql(0)
	end

	it "should return `0` for array of no elements" do
		a = MyArray[]
		n = a.size
		expect(n).to eql(0)
	end

	it "should return `1` for array of one element" do
		a = MyArray[2]
		n = a.size
		expect(n).to eql(1)
	end
end

describe "MyArray#empty?" do
	it "should return `true` for new array" do
		a = MyArray.new
		z = a.empty?
		expect(z).to eql(true)
	end

	it "should return `true` for array of no elements" do
		a = MyArray[]
		z = a.empty?
		expect(z).to eql(true)
	end

	it "should return `false` for array of one element" do
		a = MyArray[2]
		z = a.empty?
		expect(z).to eql(false)
	end
end

describe "MyArray#[]" do
	it "should return first element for array of two elements for index `0`" do
		a = MyArray[2, 3]
		e = a[0]
		expect(e).to eql(2)
	end

	it "should return second element for array of two elements for index `1`" do
		a = MyArray[2, 3]
		e = a[1]
		expect(e).to eql(3)
	end

	it "should return `nil` for array of two elements for index `2`" do
		a = MyArray[2, 3]
		e = a[2]
		expect(e).to eql(nil)
	end

	it "should return last element for array of two elements for index `-1`" do
		a = MyArray[2, 3]
		e = a[-1]
		expect(e).to eql(3)
	end

	it "should return second last element for array of two elements for index `-2`" do
		a = MyArray[2, 3]
		e = a[-2]
		expect(e).to eql(2)
	end

	it "should return `nil` for array of two elements for index `-3`" do
		a = MyArray[2, 3]
		e = a[-3]
		expect(e).to eql(nil)
	end
end

describe "MyArray#[]=" do
	it "should set first element for array of two elements for index `0`" do
		a = MyArray[2, 3]
		a[0] = 5
		expect(a).to eql(MyArray[5, 3])
	end

	it "should set second element for array of two elements for index `1`" do
		a = MyArray[2, 3]
		a[1] = 5
		expect(a).to eql(MyArray[2, 5])
	end

	it "should raise `IndexError` for array of two elements for index `2`" do
		a = MyArray[2, 3]
		expect {
			a[2] = 5
		}.to raise_error(IndexError)
	end

	it "should set last element for array of two elements for index `-1`" do
		a = MyArray[2, 3]
		a[-1] = 5
		expect(a).to eql(MyArray[2, 5])
	end

	it "should set second last element for array of two elements for index `-2`" do
		a = MyArray[2, 3]
		a[-2] = 5
		expect(a).to eql(MyArray[5, 3])
	end

	it "should raise `IndexError` for array of two elements for index `-3`" do
		a = MyArray[2, 3]
		expect {
			a[-3] = 5
		}.to raise_error(IndexError)
	end
end

describe "MyArray#pop" do
	it "should return `nil` for new array" do
		a = MyArray.new
		e = a.pop
		expect(e).to eql(nil)
	end

	it "should return `nil` for array of no elements" do
		a = MyArray[]
		e = a.pop
		expect(e).to eql(nil)
	end

	it "should remove and return last element for array of two elements" do
		a = MyArray[3, 5]
		e = a.pop
		expect(a).to eql(MyArray[3])
		expect(e).to eql(5)
	end
end

describe "MyArray#push" do
	it "should append one element to new array" do
		a = MyArray.new
		a.push(3)
		expect(a).to eql(MyArray[3])
	end

	it "should append two elements to new array" do
		a = MyArray.new
		a.push(3)
		a.push(5)
		expect(a).to eql(MyArray[3, 5])
	end

	it "should append element to array of two elements" do
		a = MyArray[3, 5]
		a.push(7)
		expect(a).to eql(MyArray[3, 5, 7])
	end
end

describe "MyArray#shift" do
	it "should return `nil` for new array" do
		a = MyArray.new
		e = a.shift
		expect(e).to eql(nil)
	end

	it "should return `nil` for array of no elements" do
		a = MyArray[]
		e = a.shift
		expect(e).to eql(nil)
	end

	it "should remove and return first element for array of two elements" do
		a = MyArray[3, 5]
		e = a.shift
		expect(a).to eql(MyArray[5])
		expect(e).to eql(3)
	end
end

describe "MyArray#unshift" do
	it "should prepend one element to new array" do
		a = MyArray.new
		a.unshift(3)
		expect(a).to eql(MyArray[3])
	end

	it "should prepend two elements to new array" do
		a = MyArray.new
		a.unshift(3)
		a.unshift(5)
		expect(a).to eql(MyArray[5, 3])
	end

	it "should prepend element to array of two elements" do
		a = MyArray[3, 5]
		a.unshift(7)
		expect(a).to eql(MyArray[7, 3, 5])
	end
end

describe "MyArray::EachMyEnumerator#peek" do
	it "should raise `StopIteration` for new array" do
		a = MyArray.new
		enum = a.to_enum
		expect {
			enum.peek
		}.to raise_error(StopIteration)
	end

	it "should raise `StopIteration` for array of no elements" do
		a = MyArray[]
		enum = a.to_enum
		expect {
			enum.peek
		}.to raise_error(StopIteration)
	end

	it "should return first element for array of two elements" do
		a = MyArray[3, 5]
		enum = a.to_enum
		e1 = enum.peek
		expect(e1).to eql(3)
		e2 = enum.peek
		expect(e2).to eql(3)
	end
end

describe "MyArray::EachMyEnumerator#next" do
	it "should raise `StopIteration` for new array" do
		a = MyArray.new
		enum = a.to_enum
		expect {
			enum.next
		}.to raise_error(StopIteration)
	end

	it "should raise `StopIteration` for array of no elements" do
		a = MyArray[]
		enum = a.to_enum
		expect {
			enum.next
		}.to raise_error(StopIteration)
	end

	it "should return each element then raise `StopIteration` for array of two elements" do
		a = MyArray[3, 5]
		enum = a.to_enum
		e1 = enum.next
		expect(e1).to eql(3)
		e2 = enum.next
		expect(e2).to eql(5)
		expect {
			enum.next
		}.to raise_error(StopIteration)
	end
end
