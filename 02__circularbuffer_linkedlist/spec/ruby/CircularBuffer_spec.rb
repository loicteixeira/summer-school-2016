require "spec_helper"

describe "CircularBuffer#eql?" do
	it "should return `true` for new buffer and buffer of no elements" do
		b1 = CircularBuffer.new(1)
		b2 = CircularBuffer[]
		z = b1.eql?(b2)
		expect(z).to eql(true)
	end

	it "should return `false` for new buffer and buffer of one `nil` element" do
		b1 = CircularBuffer.new(1)
		b2 = CircularBuffer[nil]
		z = b1.eql?(b2)
		expect(z).to eql(false)
	end

	it "should return `true` for buffers of `eql?` elements" do
		b1 = CircularBuffer[3, 5]
		b2 = CircularBuffer[3, 5]
		z = b1.eql?(b2)
		expect(z).to eql(true)
	end

	it "should return `false` for buffers with different sizes" do
		b1 = CircularBuffer[3]
		b2 = CircularBuffer[3, 5]
		z = b1.eql?(b2)
		expect(z).to eql(false)
	end

	it "should return `false` for buffers of not `eql?` elements" do
		b1 = CircularBuffer[3, 5]
		b2 = CircularBuffer[5, 3]
		z = b1.eql?(b2)
		expect(z).to eql(false)
	end
end

describe "CircularBuffer#each" do
	it "should not yield for new buffer" do
		a = CircularBuffer.new(1)
		expect { |b|
			a.each(&b)
		}.not_to yield_control
	end

	it "should not yield for buffer of no elements" do
		a = CircularBuffer[]
		expect { |b|
			a.each(&b)
		}.not_to yield_control
	end

	it "should yield each element for buffer of two elements" do
		a = CircularBuffer[3, 5]
		expect { |b|
			a.each(&b)
		}.to yield_successive_args(3, 5)
	end
end

describe "CircularBuffer#size" do
	it "should return `0` for new buffer" do
		a = CircularBuffer.new(1)
		n = a.size
		expect(n).to eql(0)
	end

	it "should return `0` for buffer of no elements" do
		a = CircularBuffer[]
		n = a.size
		expect(n).to eql(0)
	end

	it "should return `1` for buffer of one element" do
		a = CircularBuffer[2]
		n = a.size
		expect(n).to eql(1)
	end
end

describe "CircularBuffer#empty?" do
	it "should return `true` for new buffer" do
		a = CircularBuffer.new(1)
		z = a.empty?
		expect(z).to eql(true)
	end

	it "should return `true` for buffer of no elements" do
		a = CircularBuffer[]
		z = a.empty?
		expect(z).to eql(true)
	end

	it "should return `false` for buffer of one element" do
		a = CircularBuffer[2]
		z = a.empty?
		expect(z).to eql(false)
	end
end

describe "CircularBuffer#pop" do
	it "should return `nil` for new buffer" do
		a = CircularBuffer.new(1)
		e = a.pop
		expect(e).to eql(nil)
	end

	it "should return `nil` for buffer of no elements" do
		a = CircularBuffer[]
		e = a.pop
		expect(e).to eql(nil)
	end

	it "should remove and return last element for buffer of two elements" do
		a = CircularBuffer[3, 5]
		e = a.pop
		expect(a).to eql(CircularBuffer[3])
		expect(e).to eql(5)
	end
end

describe "CircularBuffer#push" do
	it "should append one element for new buffer with capacity `1`" do
		a = CircularBuffer.new(1)
		a.push(3)
		expect(a).to eql(CircularBuffer[3])
	end

	it "should raise `IndexError` for new buffer with capacity `1`" do
		a = CircularBuffer.new(1)
		a.push(3)
		expect {
			a.push(5)
		}.to raise_error(IndexError)
	end

	it "should append two elements for new buffer with capacity `2`" do
		a = CircularBuffer.new(2)
		a.push(3)
		a.push(5)
		expect(a).to eql(CircularBuffer[3, 5])
	end

	it "should raise `IndexError` for full buffer" do
		a = CircularBuffer[3, 5]
		expect {
			a.push(7)
		}.to raise_error(IndexError)
	end
end

describe "CircularBuffer#shift" do
	it "should return `nil` for new buffer" do
		a = CircularBuffer.new(1)
		e = a.shift
		expect(e).to eql(nil)
	end

	it "should return `nil` for buffer of no elements" do
		a = CircularBuffer[]
		e = a.shift
		expect(e).to eql(nil)
	end

	it "should remove and return first element for buffer of two elements" do
		a = CircularBuffer[3, 5]
		e = a.shift
		expect(a).to eql(CircularBuffer[5])
		expect(e).to eql(3)
	end
end

describe "CircularBuffer#unshift" do
	it "should prepend one element for new buffer with capacity `1`" do
		a = CircularBuffer.new(1)
		a.unshift(3)
		expect(a).to eql(CircularBuffer[3])
	end

	it "should raise `IndexError` for new buffer with capacity `1`" do
		a = CircularBuffer.new(1)
		a.unshift(3)
		expect {
			a.unshift(5)
		}.to raise_error(IndexError)
	end

	it "should prepend two elements for new buffer with capacity `2`" do
		a = CircularBuffer.new(2)
		a.unshift(3)
		a.unshift(5)
		expect(a).to eql(CircularBuffer[5, 3])
	end

	it "should raise `IndexError` for full buffer" do
		a = CircularBuffer[3, 5]
		expect {
			a.unshift(7)
		}.to raise_error(IndexError)
	end
end
