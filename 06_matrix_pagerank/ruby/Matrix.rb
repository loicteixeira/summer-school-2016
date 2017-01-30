#
# This class implements a matrix:
#
#   https://en.wikipedia.org/wiki/Matrix_(mathematics)
#
# A matrix has three fields:
#
#   `@m` is the memory for the elements.
#
#   `@row_count` is the number of rows.
#
#   `@column_count` is the number of columns.
#
## <>
##   @m: Memory<Memory<Numeric>>
##   @row_count: Integer
##   @column_count: Integer
class Matrix
	#
	# This class implements a view of a row of a matrix.
	#
	# A row vector has two fields:
	#
	#   `@matrix` is the backing matrix.
	#
	#   `@i` is the row number.
	#
	## <>
	##   @matrix: Matrix
	##   @i: Integer
	class RowVector < Vector
		#
		# `initialize`
		#   is called by the VM for a new vector.
		#
		## Matrix, Integer -> void
		def initialize(matrix, i)
			super()
			@matrix = matrix
			@i = i
			return
		end

		#
		# `__get`
		#   returns element at column `j`.
		#
		## Integer -> Numeric
		def __get(j)
			return @matrix.__get(@i, j)
		end

		#
		# `size`
		#   returns the size of the vector.
		#
		## -> Integer
		def size
			return @matrix.column_count
		end
	end

	#
	# This class implements a view of a column of a matrix.
	#
	# A column vector has two fields:
	#
	#   `@matrix` is the backing matrix.
	#
	#   `@j` is the column number.
	#
	## <>
	##   @matrix: Matrix
	##   @j: Integer
	class ColumnVector < Vector
		#
		# `initialize`
		#   is called by the VM for a new vector.
		#
		## Matrix, Integer -> void
		def initialize(matrix, j)
			super()
			@matrix = matrix
			@j = j
			return
		end

		#
		# `__get`
		#   returns element at row `i`.
		#
		## Integer -> Numeric
		def __get(i)
			return @matrix.__get(i, @j)
		end

		#
		# `size`
		#   returns the size of the vector.
		#
		## -> Integer
		def size
			return @matrix.row_count
		end
	end

	class << self
		## -> void
		def new
			raise RuntimeError.new
		end

		#
		# `[]`
		#   returns a new matrix with given values.
		#
		# Example:
		#
		#   matrix = Matrix[[1, 0], [0, 1]]
		#
		## *Array<Numeric> -> Matrix
		def [](*rows)
			row_count = rows.size
			i = 0
			unless i < row_count
				return Matrix.__new__(Memory[], 0, 0)
			end
			column_count = rows.fetch(i).size
			i += 1
			while i < row_count
				if column_count != rows.fetch(i).size
					raise ArgumentError.new("inconsistent column count")
				end
				i += 1
			end
			m = Memory.new(row_count) { |i|
				Memory[*rows.fetch(i)]
			}
			return Matrix.__new__(m, row_count, column_count)
		end

		#
		# `build`
		#   returns a new matrix with values given by the block.
		#
		# Example:
		#
		#   matrix = Matrix.build(2, 2) { |i, j| i == j ? 1 : 0 }
		#
		## Integer, Integer, &{Integer, Integer -> Numeric} -> Matrix
		def build(row_count, column_count)
			m = Memory.new(row_count) { |i|
				Memory.new(column_count) { |j|
					yield(i, j)
				}
			}
			return Matrix.__new__(m, row_count, column_count)
		end

		#
		# `diagonal`
		#   returns a new matrix with given values on the diagonal.
		#
		# Example:
		#
		#   matrix = Matrix.diagonal(1, 1)
		#
		## *Numeric -> Matrix
		def diagonal(*values)
			n = values.size
			m = Memory.new(n) { |i|
				Memory.new(n) { |j|
					i == j ? values.fetch(i) : 0
				}
			}
			return Matrix.__new__(m, n, n)
		end

		#
		# `identity`
		#   returns a new identity matrix.
		#
		# Example:
		#
		#   matrix = Matrix.identity(2)
		#
		## Integer -> Matrix
		def identity(n)
			m = Memory.new(n) { |i|
				Memory.new(n) { |j|
					i == j ? 1 : 0
				}
			}
			return Matrix.__new__(m, n, n)
		end

		#
		# `scalar`
		#   returns a new scalar matrix.
		#
		# Example:
		#
		#   matrix = Matrix.scalar(2, 1)
		#
		## Integer, Numeric -> Matrix
		def scalar(n, value)
			m = Memory.new(n) { |i|
				Memory.new(n) { |j|
					i == j ? value : 0
				}
			}
			return Matrix.__new__(m, n, n)
		end

		#
		# `zero`
		#   returns a new zero matrix.
		#
		# Example:
		#
		#   matrix = Matrix.zero(2, 2)
		#
		## Integer, Integer -> Matrix
		def zero(row_count, column_count)
			m = Memory.new(row_count) { |i|
				Memory.new(column_count) { |j|
					0
				}
			}
			return Matrix.__new__(m, row_count, column_count)
		end
	end

	#
	# `initialize`
	#   is called by the VM for a new matrix.
	#
	## Memory<Memory<Numeric>>, Integer, Integer -> void
	def initialize(m, row_count, column_count)
		super()
		@m = m
		@row_count = row_count
		@column_count = column_count
		return
	end

	attr_reader :row_count, :column_count

	#
	# `__assert_bounds`
	#   asserts row `i` and column `j` are within bounds.
	#
	## Integer, Integer -> void
	def __assert_bounds(i, j)
		if i < 0 || i >= @row_count || j < 0 || j >= @column_count
			raise IndexError.new("index out of bounds for #{@row_count}x#{@column_count}: #{i},#{j}")
		end
		return
	end

	#
	# `__get`
	#   returns element at row `i` and column `j` from the memory.
	#
	## Integer, Integer -> Numeric
	def __get(i, j)
		return @m[i][j]
	end

	#
	# `eql?`
	#   returns whether the elements `eql?` the elements of `o`.
	#
	# Example:
	#
	#   matrix1 = Matrix[[3, 0], [0, 5]]
	#   matrix2 = Matrix[[5, 0], [0, 3]]
	#   matrix1.eql?(matrix2) # => false
	#
	## ..Object? -> boolean
	def eql?(o)
		if o.is_a?(Matrix)
			if @row_count == o.row_count && @column_count == o.column_count
				@row_count.times do |i|
					@column_count.times do |j|
						unless @m[i][j].eql?(o.__get(i, j))
							return false
						end
					end
				end
				return true
			end
		end
		return false
	end

	#
	# `[]`
	#   returns element at row `i` and column `j`, if within bounds,
	#   or raises `IndexError` otherwise.
	#
	# Example:
	#
	#   matrix = Matrix[[3, 0], [0, 5]]
	#   matrix[1, 1] # => 5
	#
	## Integer, Integer -> Numeric
	def [](i, j)
		__assert_bounds(i, j)
		return @m[i][j]
	end

	#
	# `row`
	#   returns vector for row `i`.
	#
	## Integer -> Vector
	def row(i)
		return RowVector.__new__(self, i)
	end

	#
	# `column`
	#   returns vector for column `j`.
	#
	## Integer -> Vector
	def column(j)
		return ColumnVector.__new__(self, j)
	end

	#
	# `__add`
	#   returns new matrix where the element at row `i` and column `j`
	#   is the sum of the corresponding elements in `self` and `other`.
	#
	# Example:
	#
	#   matrix1 = Matrix[[1, 2], [2, 3]]
	#   matrix2 = Matrix[[2, 3], [3, 5]]
	#   matrix1 + matrix2 # => Matrix[[3, 5], [5, 8]]
	#
	# Write about 5 lines of code for this method.
	#
	## Matrix -> Matrix
	def __add(other)
		m = Memory.new(@row_count) { |i|
			Memory.new(@column_count) { |j|
				@m[i][j] + other.__get(i, j)
			}
		}
		return Matrix.__new__(m, @row_count, @column_count)
	end

	## Matrix -> Matrix
	def +(other)
		if @row_count != other.row_count || @column_count != other.column_count
			raise ArgumentError.new("incompatible: #{@row_count}x#{@column_count} + #{other.row_count}x#{other.column_count}")
		end
		return __add(other)
	end

	#
	# `__sub`
	#   returns new matrix where the element at row `i` and column `j`
	#   is the difference of the corresponding elements in `self` and `other`.
	#
	# Example:
	#
	#   matrix1 = Matrix[[3, 5], [5, 8]]
	#   matrix2 = Matrix[[1, 2], [2, 3]]
	#   matrix1 - matrix2 # => Matrix[[2, 3], [3, 5]]
	#
	# Write about 5 lines of code for this method.
	#
	## Matrix -> Matrix
	def __sub(other)
		m = Memory.new(@row_count) { |i|
			Memory.new(@column_count) { |j|
				@m[i][j] - other.__get(i, j)
			}
		}
		return Matrix.__new__(m, @row_count, @column_count)
	end

	## Matrix -> Matrix
	def -(other)
		if @row_count != other.row_count || @column_count != other.column_count
			raise ArgumentError.new("incompatible: #{@row_count}x#{@column_count} - #{other.row_count}x#{other.column_count}")
		end
		return __sub(other)
	end

	#
	# `__mul_numeric`
	#   returns new matrix where the element at row `i` and column `j`
	#   is the corresponding element in `self` multipied by `other`.
	#
	# Example:
	#
	#   matrix = Matrix[[1, 2], [2, 3]]
	#   matrix * 2 # => Matrix[[2, 4], [4, 6]]
	#
	# Write about 5 lines of code for this method.
	#
	## Numeric -> Matrix
	def __mul_numeric(other)
		m = Memory.new(@row_count) { |i|
			Memory.new(@column_count) { |j|
				@m[i][j] * other
			}
		}
		return Matrix.__new__(m, @row_count, @column_count)
	end

	#
	# `__mul_vector`
	#   returns new vector where the element at index `i`
	#   is the inner product of row `i` of `self` and `other`.
	#
	# Example:
	#
	#   matrix = Matrix[[0, 1], [1, 0]]
	#   vector = Vector[1, 2]
	#   matrix * vector # => Vector[2, 1]
	#
	# Write about 5 lines of code for this method.
	#
	## Vector -> Vector
	def __mul_vector(other)
		m = Memory.new(@row_count) { |i|
			row(i).__inner_product(other)
		}
		return Vector::MemoryVector.__new__(m)
	end

	#
	# `__mul_matrix`
	#   returns new matrix where the element at row `i` and column `j`
	#   is the inner product of row `i` of `self` and column `j` of `other`.
	#
	# Example:
	#
	#   matrix1 = Matrix[[0, 1], [1, 0]]
	#   matrix2 = Matrix[[1, 2], [2, 3]]
	#   matrix1 * matrix2 # => Matrix[[2, 3], [1, 2]]
	#
	# Write about 5 lines of code for this method.
	#
	## Matrix -> Matrix
	def __mul_matrix(other)
		m = Memory.new(@row_count) { |i|
			Memory.new(other.column_count) { |j|
				row(i).__inner_product(other.column(j))
			}
		}
		return Matrix.__new__(m, @row_count, other.column_count)
	end

	## Numeric -> Matrix
	## Vector -> Vector
	## Matrix -> Matrix
	def *(other)
		case other
		when Numeric
			return __mul_numeric(other)
		when Vector
			if @column_count != other.size
				raise ArgumentError.new("incompatible: #{@row_count}x#{@column_count} * #{other.size}x1")
			end
			return __mul_vector(other)
		when Matrix
			if @column_count != other.row_count
				raise ArgumentError.new("incompatible: #{@row_count}x#{@column_count} * #{other.row_count}x#{other.column_count}")
			end
			return __mul_matrix(other)
		else
			raise TypeError.new
		end
	end

	#
	# `transpose`
	#   returns new matrix where the element at row `i` and column `j`
	#   is the element at row `j` and column `i` of `self`.
	#
	# Example:
	#
	#   matrix = Matrix[[1, 2, 3], [1, 2, 4]]
	#   matrix.transpose # => Matrix[[1, 1], [2, 2], [3, 4]]
	#
	# Write about 5 lines of code for this method.
	#
	## -> Matrix
	def transpose
		m = Memory.new(@column_count) { |i|
			Memory.new(@row_count) { |j|
				@m[j][i]
			}
		}
		return Matrix.__new__(m, @column_count, @row_count)
	end
end
