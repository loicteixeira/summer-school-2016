require "spec_helper"

describe "Algorithms.shuffle" do
	it "should return new memory with shuffled elements" do
		r = Random.new(0)
		m1 = Memory[2, 3, 5]
		m2 = Algorithms.shuffle(r, m1)
		expect(m1).to eql(Memory[2, 3, 5])
		expect(m2).to eql(Memory[3, 5, 2])
	end

	it "should return new memory with shuffled elements" do
		r = Random.new(0)
		m1 = Memory[2, 3, 5, 7]
		m2 = Algorithms.shuffle(r, m1)
		expect(m1).to eql(Memory[2, 3, 5, 7])
		expect(m2).to eql(Memory[7, 5, 2, 3])
	end
end

describe "Algorithms.shuffle!" do
	it "should shuffle elements" do
		r = Random.new(0)
		m = Memory[2, 3, 5]
		Algorithms.shuffle!(r, m)
		expect(m).to eql(Memory[5, 3, 2])
	end

	it "should shuffle elements" do
		r = Random.new(0)
		m = Memory[2, 3, 5, 7]
		Algorithms.shuffle!(r, m)
		expect(m).to eql(Memory[5, 7, 3, 2])
	end
end

describe "Algorithms.binary_search" do
	it "should return `true` if element in memory" do
		m = Memory[3, 5, 7]
		z = Algorithms.binary_search(m, 3)
		expect(z).to eql(true)
	end

	it "should return `true` if element in memory" do
		m = Memory[3, 5, 7]
		z = Algorithms.binary_search(m, 5)
		expect(z).to eql(true)
	end

	it "should return `true` if element in memory" do
		m = Memory[3, 5, 7]
		z = Algorithms.binary_search(m, 7)
		expect(z).to eql(true)
	end

	it "should return `false` if element not in memory" do
		m = Memory[3, 5, 7]
		z = Algorithms.binary_search(m, 2)
		expect(z).to eql(false)
	end

	it "should return `false` if element not in memory" do
		m = Memory[3, 5, 7]
		z = Algorithms.binary_search(m, 4)
		expect(z).to eql(false)
	end

	it "should return `false` if element not in memory" do
		m = Memory[3, 5, 7]
		z = Algorithms.binary_search(m, 6)
		expect(z).to eql(false)
	end

	it "should return `false` if element not in memory" do
		m = Memory[3, 5, 7]
		z = Algorithms.binary_search(m, 8)
		expect(z).to eql(false)
	end

	it "should return `true` if element in memory" do
		m = Memory[2, 4, 6, 8]
		z = Algorithms.binary_search(m, 2)
		expect(z).to eql(true)
	end

	it "should return `true` if element in memory" do
		m = Memory[2, 4, 6, 8]
		z = Algorithms.binary_search(m, 4)
		expect(z).to eql(true)
	end

	it "should return `true` if element in memory" do
		m = Memory[2, 4, 6, 8]
		z = Algorithms.binary_search(m, 6)
		expect(z).to eql(true)
	end

	it "should return `true` if element in memory" do
		m = Memory[2, 4, 6, 8]
		z = Algorithms.binary_search(m, 8)
		expect(z).to eql(true)
	end

	it "should return `false` if element not in memory" do
		m = Memory[2, 4, 6, 8]
		z = Algorithms.binary_search(m, 1)
		expect(z).to eql(false)
	end

	it "should return `false` if element not in memory" do
		m = Memory[2, 4, 6, 8]
		z = Algorithms.binary_search(m, 3)
		expect(z).to eql(false)
	end

	it "should return `false` if element not in memory" do
		m = Memory[2, 4, 6, 8]
		z = Algorithms.binary_search(m, 5)
		expect(z).to eql(false)
	end

	it "should return `false` if element not in memory" do
		m = Memory[2, 4, 6, 8]
		z = Algorithms.binary_search(m, 7)
		expect(z).to eql(false)
	end

	it "should return `false` if element not in memory" do
		m = Memory[2, 4, 6, 8]
		z = Algorithms.binary_search(m, 9)
		expect(z).to eql(false)
	end
end

describe "Algorithms.kmp_table" do
	it "should return table" do
		table = Algorithms.kmp_table(Memory[2, 2, 0])
		expect(table).to eql(Memory[nil, 0, 1])
	end

	it "should return table" do
		table = Algorithms.kmp_table(Memory[2, 2, 2, 0])
		expect(table).to eql(Memory[nil, 0, 1, 2])
	end

	it "should return table" do
		table = Algorithms.kmp_table(Memory[2, 3, 0])
		expect(table).to eql(Memory[nil, 0, 0])
	end

	it "should return table" do
		table = Algorithms.kmp_table(Memory[2, 3, 2, 3, 0])
		expect(table).to eql(Memory[nil, 0, 0, 1, 2])
	end
end

describe "Algorithms.kmp_search" do
	it "should yield" do
		expect { |p|
			Algorithms.kmp_search(Memory[2, 2, 3], Memory[2, 2, 4, 2, 2, 3], &p)
		}.to yield_successive_args(3)
	end
end
