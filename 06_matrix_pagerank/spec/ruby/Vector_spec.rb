require "spec_helper"

describe "Vector#eql?" do
	it "should return `true` for vectors of `eql?` elements" do
		vector1 = Vector[3, 5]
		vector2 = Vector[3, 5]
		z = vector1.eql?(vector2)
		expect(z).to eql(true)
	end

	it "should return `true` for vectors of not `eql?` elements" do
		vector1 = Vector[3, 5]
		vector2 = Vector[5, 3]
		z = vector1.eql?(vector2)
		expect(z).to eql(false)
	end
end

describe "Vector#+" do
	it "should return sum of vectors" do
		vector1 = Vector[1, 1]
		vector2 = Vector[1, 0]
		vector3 = vector1 + vector2
		expect(vector3).to eql(Vector[2, 1])
	end
end

describe "Vector#-" do
	it "should return difference of vectors" do
		vector1 = Vector[1, 1]
		vector2 = Vector[1, 0]
		vector3 = vector1 - vector2
		expect(vector3).to eql(Vector[0, 1])
	end
end

describe "Vector#*" do
	it "should return vector multiplied by numeric" do
		vector1 = Vector[2, 3]
		vector2 = vector1 * 2
		expect(vector2).to eql(Vector[4, 6])
	end

	it "should return vector multiplied by matrix" do
		vector1 = Vector[2, 3]
		matrix = Matrix[[0, 1, 0, 1], [0, 0, 1, 1]]
		vector2 = vector1 * matrix
		expect(vector2).to eql(Vector[0, 2, 3, 5])
	end
end

describe "Vector#inner_product" do
	it "should return inner product of vectors" do
		vector1 = Vector[2, 3]
		vector2 = Vector[3, 5]
		t = vector1.inner_product(vector2)
		expect(t).to eql(21)
	end
end

describe "Vector#magnitude" do
	it "should return magnitude of vector" do
		vector = Vector[3, 4]
		r = vector.magnitude
		expect(r).to eql(5.0)
	end
end
