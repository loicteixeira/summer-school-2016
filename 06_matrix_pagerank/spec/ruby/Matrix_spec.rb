require "spec_helper"

describe "Matrix#eql?" do
	it "should return `true` for matrices of `eql?` elements" do
		matrix1 = Matrix[[1, 0], [0, 1]]
		matrix2 = Matrix[[1, 0], [0, 1]]
		z = matrix1.eql?(matrix2)
		expect(z).to eql(true)
	end

	it "should return `true` for matrices of not `eql?` elements" do
		matrix1 = Matrix[[1, 0], [0, 1]]
		matrix2 = Matrix[[1, 1], [0, 1]]
		z = matrix1.eql?(matrix2)
		expect(z).to eql(false)
	end
end

describe "Matrix#+" do
	it "should return sum of matrices" do
		matrix1 = Matrix[[1, 1], [0, 1]]
		matrix2 = Matrix[[1, 0], [0, 1]]
		matrix3 = matrix1 + matrix2
		expect(matrix3).to eql(Matrix[[2, 1], [0, 2]])
	end
end

describe "Matrix#-" do
	it "should return difference of matrices" do
		matrix1 = Matrix[[1, 1], [0, 1]]
		matrix2 = Matrix[[1, 0], [0, 1]]
		matrix3 = matrix1 - matrix2
		expect(matrix3).to eql(Matrix[[0, 1], [0, 0]])
	end
end

describe "Matrix#*" do
	it "should return matrix multiplied by numeric" do
		matrix1 = Matrix[[1, 2], [0, 3]]
		matrix2 = matrix1 * 2
		expect(matrix2).to eql(Matrix[[2, 4], [0, 6]])
	end
end

describe "Matrix#*" do
	it "should return matrix multiplied by vector" do
		matrix = Matrix[[0, 0], [1, 0], [0, 1], [1, 1]]
		vector1 = Vector[2, 3]
		vector2 = matrix * vector1
		expect(vector2).to eql(Vector[0, 2, 3, 5])
	end
end

describe "Matrix#*" do
	it "should return matrix multiplied by matrix" do
		matrix1 = Matrix[[1, 1, 0], [0, 1, 1]]
		matrix2 = Matrix[[1, 2], [2, 3], [3, 5]]
		matrix3 = matrix1 * matrix2
		expect(matrix3).to eql(Matrix[[3, 5], [5, 8]])
	end
end

describe "Matrix#transpose" do
	it "should return matrix multiplied by vector" do
		matrix1 = Matrix[[0, 0], [1, 0], [0, 1], [1, 1]]
		matrix2 = matrix1.transpose
		expect(matrix2).to eql(Matrix[[0, 1, 0, 1], [0, 0, 1, 1]])
	end
end
