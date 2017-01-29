#
# This abstract class represents a vector:
#
#   https://en.wikipedia.org/wiki/Vector_(mathematics)
#
## <>
##   #__get: Integer -> Numeric
##   #size: -> Integer
class Vector
	#
	# This class implements a vector backed by memory.
	#
	# A vector has one field:
	#
	#   `@m` is the memory for the elements.
	#
	## <>
	##   @m: Memory<Numeric>
	class MemoryVector < Vector
		#
		# `initialize`
		#   is called by the VM for a new vector.
		#
		## Memory<Numeric> -> void
		def initialize(m)
			super()
			@m = m
			return
		end

		#
		# `__get`
		#   returns element at index `k`.
		#
		## Integer -> Numeric
		def __get(k)
			return @m[k]
		end

		#
		# `size`
		#   returns the size of the vector.
		#
		## -> Integer
		def size
			return @m.capacity
		end
	end

	class << self
		## -> void
		def new
			raise RuntimeError.new
		end

		#
		# `[]`
		#   returns a new vector with given values.
		#
		# Example:
		#
		#   vector = Vector[2, 3]
		#
		## *Numeric -> Vector
		def [](*values)
			m = Memory[*values]
			return MemoryVector.__new__(m)
		end

		#
		# `build`
		#   returns a new vector with values given by the block.
		#
		# Example:
		#
		#   vector = Vector.build(2) { |k| k }
		#
		## Integer, &{Integer -> Numeric} -> Vector
		def build(n)
			m = Memory.new(n) { |k|
				yield(k)
			}
			return MemoryVector.__new__(m)
		end
	end

	#
	# `__assert_bounds`
	#   asserts index `k` is within bounds.
	#
	## Integer -> void
	def __assert_bounds(k)
		if k < 0 || k >= size
			raise IndexError.new("index out of bounds for #{size}: #{k}")
		end
		return
	end

	#
	# `eql?`
	#   returns whether the elements `eql?` the elements of `o`.
	#
	# Example:
	#
	#   vector1 = Vector[3, 5]
	#   vector2 = Vector[5, 3]
	#   vector1.eql?(vector2) # => false
	#
	## ..Object? -> boolean
	def eql?(o)
		if o.is_a?(Vector)
			if size == o.size
				size.times do |k|
					unless __get(k).eql?(o.__get(k))
						return false
					end
				end
				return true
			end
		end
		return false
	end

	#
	# `[]`
	#   returns element at index `k`, if within bounds,
	#   or raises `IndexError` otherwise.
	#
	# Example:
	#
	#   vector = Vector[2, 3]
	#   vector[0] # => 2
	#
	## Integer -> Numeric
	def [](k)
		__assert_bounds(k)
		return __get(k)
	end

	#
	# `__add`
	#   returns new vector where the element at row `i` and column `j`
	#   is the sum of the corresponding elements in `self` and `other`.
	#
	# Example:
	#
	#   vector1 = Vector[1, 2]
	#   vector2 = Vector[2, 3]
	#   vector1 + vector2 # => Vector[3, 5]
	#
	# Write about 3 lines of code for this method.
	#
	## Vector -> Vector
	def __add(other)
		raise NotImplementedError
	end

	## Vector -> Vector
	def +(other)
		if size != other.size
			raise ArgumentError.new("incompatible: #{size} + #{other.size}")
		end
		return __add(other)
	end

	#
	# `__sub`
	#   returns new vector where the element at row `i` and column `j`
	#   is the difference of the corresponding elements in `self` and `other`.
	#
	# Example:
	#
	#   vector1 = Vector[3, 5]
	#   vector2 = Vector[1, 2]
	#   vector1 - vector2 # => Vector[2, 3]
	#
	# Write about 3 lines of code for this method.
	#
	## Vector -> Vector
	def __sub(other)
		raise NotImplementedError
	end

	## Vector -> Vector
	def -(other)
		if size != other.size
			raise ArgumentError.new("incompatible: #{size} - #{other.size}")
		end
		return __sub(other)
	end

	#
	# `__mul_numeric`
	#   returns new vector where the element at index `i`
	#   is the corresponding element in `self` multipied by `other`.
	#
	# Example:
	#
	#   vector = Vector[1, 2]
	#   vector * 2 # => Vector[2, 4]
	#
	# Write about 3 lines of code for this method.
	#
	## Numeric -> Vector
	def __mul_numeric(other)
		raise NotImplementedError
	end

	#
	# `__mul_matrix`
	#   returns new vector where the element at index `j`
	#   is the inner product of `other` and column `j` of `self`.
	#
	# Example:
	#
	#   vector = Vector[1, 2]
	#   matrix = Matrix[[0, 1], [1, 0]]
	#   vector * matrix # => Vector[2, 1]
	#
	# Write about 3 lines of code for this method.
	#
	## Matrix -> Vector
	def __mul_matrix(other)
		raise NotImplementedError
	end

	## Numeric -> Vector
	## Matrix -> Vector
	def *(other)
		case other
		when Numeric
			return __mul_numeric(other)
		when Matrix
			if size != other.row_count
				raise ArgumentError.new("incompatible: 1x#{size} * #{other.row_count}x#{other.column_count}")
			end
			return __mul_matrix(other)
		else
			raise TypeError.new
		end
	end

	#
	# `__inner_product`
	#   returns the inner product of `self` and `other`.
	#
	# Example:
	#
	#   vector1 = Vector[1, 2]
	#   vector2 = Vector[2, 3]
	#   vector1.inner_product(vector2) # => 8
	#
	# Write about 5 lines of code for this method.
	#
	## Vector -> Numeric
	def __inner_product(other)
		raise NotImplementedError
	end

	## Vector -> Numeric
	def inner_product(other)
		if size != other.size
			raise ArgumentError.new("incompatible: 1x#{size} * #{other.size}x1")
		end
		return __inner_product(other)
	end

	#
	# `magnitude`
	#   returns magnitude of vector.
	#
	# Example:
	#
	#   vector = Vector[3, 4]
	#   vector.magnitude # => 5
	#
	# Write about 5 lines of code for this method.
	#
	## -> Float
	def magnitude
		raise NotImplementedError
	end
end
