require "spec_helper"

describe "MyHash#eql?" do
	it "should return `true` for hashes of `eql?` elements" do
		h1 = MyHash[2 => 0, 3 => 1]
		h2 = MyHash[3 => 1, 2 => 0]
		z = h1.eql?(h2)
		expect(z).to eql(true)
	end

	it "should return `false` for hashes with different sizes" do
		h1 = MyHash[2 => 0]
		h2 = MyHash[2 => 0, 3 => 1]
		z = h1.eql?(h2)
		expect(z).to eql(false)
	end

	it "should return `false` for hashes of not `eql?` elements" do
		h1 = MyHash[2 => 0, 3 => 1]
		h2 = MyHash[2 => 1, 3 => 0]
		z = h1.eql?(h2)
		expect(z).to eql(false)
	end
end

describe "MyHash#size" do
	it "should return `0` for new hash" do
		h = MyHash.new
		n = h.size
		expect(n).to eql(0)
	end

	it "should return `0` for hash of no elements" do
		h = MyHash[]
		n = h.size
		expect(n).to eql(0)
	end

	it "should return `1` for hash of one element" do
		h = MyHash[2 => 0]
		n = h.size
		expect(n).to eql(1)
	end
end

describe "MyHash#empty?" do
	it "should return `true` for new hash" do
		h = MyHash.new
		z = h.empty?
		expect(z).to eql(true)
	end

	it "should return `true` for hash of no elements" do
		h = MyHash[]
		z = h.empty?
		expect(z).to eql(true)
	end

	it "should return `false` for hash of one element" do
		h = MyHash[2 => 0]
		z = h.empty?
		expect(z).to eql(false)
	end
end

describe "MyHash#key?" do
	it "should return `false` for hash of no elements" do
		h = MyHash[]
		z = h.key?(2)
		expect(z).to eql(false)
	end

	it "should return `true` for key in first node of list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		z = h.key?(3)
		expect(z).to eql(true)
	end

	it "should return `true` for key in second node of list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		z = h.key?(5)
		expect(z).to eql(true)
	end

	it "should return `false` for key not in list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		z = h.key?(7)
		expect(z).to eql(false)
	end
end

describe "MyHash#value?" do
	it "should return `false` for hash without value" do
		h = MyHash[3 => 1, 5 => 2]
		z = h.value?(0)
		expect(z).to eql(false)
	end

	it "should return `true` for hash with value in first node in list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		z = h.value?(1)
		expect(z).to eql(true)
	end

	it "should return `true` for hash with value in second node in list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		z = h.value?(2)
		expect(z).to eql(true)
	end
end

describe "MyHash#[]" do
	it "should return `nil` for hash of no elements" do
		h = MyHash[]
		e = h[2]
		expect(e).to eql(nil)
	end

	it "should return value for key in first node of list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		e = h[3]
		expect(e).to eql(1)
	end

	it "should return value for key in second node of list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		e = h[5]
		expect(e).to eql(2)
	end

	it "should return `nil` for key not in list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		e = h[7]
		expect(e).to eql(nil)
	end
end

describe "MyHash#[]=" do
	it "should return `false` for hash of no elements" do
		h = MyHash[]
		h[2] = 0
		expect(h).to eql(MyHash[2 => 0])
	end

	it "should return `true` for key in first node of list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		h[3] = -1
		expect(h).to eql(MyHash[3 => -1, 5 => 2])
	end

	it "should return `true` for key in second node of list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		h[5] = -2
		expect(h).to eql(MyHash[3 => 1, 5 => -2])
	end

	it "should return `false` for key not in list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		h[7] = -3
		expect(h).to eql(MyHash[3 => 1, 5 => 2, 7 => -3])
	end
end

describe "MyHash#delete" do
	it "should return `nil` for hash of no elements" do
		h = MyHash[]
		e = h.delete(2)
		expect(h).to eql(MyHash[])
		expect(e).to eql(nil)
	end

	it "should return value for key in first node of list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		e = h.delete(3)
		expect(h).to eql(MyHash[5 => 2])
		expect(e).to eql(1)
	end

	it "should return value for key in second node of list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		e = h.delete(5)
		expect(h).to eql(MyHash[3 => 1])
		expect(e).to eql(2)
	end

	it "should return `nil` for key not in list of two elements" do
		h = MyHash[3 => 1, 5 => 2]
		e = h.delete(7)
		expect(h).to eql(MyHash[3 => 1, 5 => 2])
		expect(e).to eql(nil)
	end
end
