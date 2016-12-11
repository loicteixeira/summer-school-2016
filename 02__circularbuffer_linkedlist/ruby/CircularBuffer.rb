#
# This class implements a circular buffer:
#
#   https://en.wikipedia.org/wiki/Circular_buffer
#
# Example:
#
#   b = CircularBuffer[2, 3]
#   b.shift # => 2
#   b.shift # => 3
#
# A buffer has four fields:
#
#   `m` is the memory for the elements.
#
#   `n` is the number of elements.
#     This must be no greater than the capacity.
#
#   `i` is the index of the next element to read.
#     This must be less than the capacity.
#
#   `j` is the index of the next element to write.
#     This must be less than the capacity.
#
## <E: ..Object?>
##   @m: Memory<E>
##   @n: Integer
##   @i: Integer
##   @j: Integer
class CircularBuffer
	class << self
		#
		# `new`
		#   returns a new buffer with capacity of `c` elements.
		#
		# Example:
		#
		#   b = CircularBuffer.new(1)
		#
		## Integer -> CircularBuffer
		def new(c)
			m = Memory.new(c)
			return CircularBuffer.__new__(m, 0)
		end

		#
		# `[]`
		#   returns a new buffer of the given values.
		#
		# Example:
		#
		#   b = CircularBuffer[2, 3]
		#
		## <E: ..Object?> *E -> CircularBuffer<E>
		def [](*values)
			m = Memory[*values]
			return CircularBuffer.__new__(m, values.size)
		end
	end

	#
	# `initialize`
	#   is called by the VM for a new buffer.
	#
	## Memory<E>, Integer -> void
	def initialize(m, n)
		super()
		@m = m
		@n = n
		@i = 0
		@j = 0
		return
	end

	#
	# `eql?`
	#   returns whether the elements `eql?` the elements of `o`.
	#
	# Example:
	#
	#   b1 = CircularBuffer[3, 5]
	#   b2 = CircularBuffer[5, 3]
	#   b1.eql?(b2) # => false
	#
	## ..Object? -> boolean
	def eql?(o)
		if o.is_a?(CircularBuffer)
			if @n == o.size
				i = @i
				o.each do |e|
					unless @m[i].eql?(e)
						return false
					end
					i += 1
					if i == @m.capacity
						i = 0
					end
				end
				return true
			end
		end
		return false
	end

	#
	# `each`
	#   yields each element.
	#
	# Example:
	#
	#   b = CircularBuffer[2, 3]
	#   b.each do |e|
	#     # ...
	#   end
	#
	## &{E -> void} -> void
	def each
		i = @i
		@n.times do
			yield @m[i]
			i += 1
			if i == @m.capacity
				i = 0
			end
		end
		return
	end

	#
	# `size`
	#   returns the number of elements.
	#
	# Example:
	#
	#   b = CircularBuffer[2]
	#   b.size # => 1
	#
	## -> Integer
	def size
		return @n
	end

	#
	# `empty?`
	#   returns whether this buffer is empty.
	#
	# Example:
	#
	#   b = CircularBuffer.new(3)
	#   b.empty? # => true
	#
	## -> boolean
	def empty?
		return @n.zero?
	end

	#
	# `full?`
	#   returns whether this buffer is full.
	#
	# Example:
	#
	#   b = CircularBuffer[2, 3]
	#   b.full? # => true
	#
	## -> boolean
	def full?
		return @n == @m.capacity
	end

	#
	# `first`
	#   returns the first element, if any,
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   b = CircularBuffer[2, 3, 5]
	#   b.first # => 2
	#
	# Write about 4 lines of code for this method.
	#
	## -> E?
	def first
		return if empty?
		@m[@i]
	end

	#
	# `last`
	#   returns the last element, if any,
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   b = CircularBuffer[2, 3, 5]
	#   b.last # => 5
	#
	# Write about 9 lines of code for this method.
	#
	## -> E?
	def last
		return if empty?
		i = __ensure_in_bounds(@j - 1)
		@m[i]
	end

	#
	# `pop`
	#   returns the last element, if any,
	#   (and removes the element in that case)
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   b = CircularBuffer[2, 3]
	#   b.pop # => 3
	#
	# Write about 13 lines of code for this method.
	#
	## -> E?
	def pop
		return if empty?
		@j = __ensure_in_bounds(@j - 1)
		e = last
		@m[@j] = nil
		@n -= 1
		e
	end

	#
	# `push`
	#   appends `e` to this buffer, if not full,
	#   or raises `IndexError` otherwise.
	#
	# Example:
	#
	#   b = CircularBuffer[2, 3]
	#   b.push(5)
	#
	# Write about 11 lines of code for this method.
	#
	## E -> void
	def push(e)
		raise IndexError if full?
		@m[@j] = e
		@j += 1
		@n += 1
	end

	#
	# `shift`
	#   returns the first element, if any,
	#   (and removes the element in that case)
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   b = CircularBuffer[2, 3]
	#   b.shift # => 2
	#
	# Write about 13 lines of code for this method.
	#
	## -> E?
	def shift
		return if empty?
		e = first
		@m[@i] = nil
		@i = __ensure_in_bounds(@i + 1)
		@n -= 1
		e
	end

	#
	# `unshift`
	#   prepends `e` to this buffer, if not full,
	#   or raises `IndexError` otherwise.
	#
	# Example:
	#
	#   b = CircularBuffer[2, 3]
	#   b.unshift(5)
	#
	# Write about 11 lines of code for this method.
	#
	## E -> void
	def unshift(e)
		raise IndexError if full?
		@i = __ensure_in_bounds(@i - 1)
		@m[@i] = e
		@n += 1
	end

	def __ensure_in_bounds(v)
		if v < 0
			return v + @m.capacity
		elsif v >= @m.capacity
			return v - @m.capacity
		else
			return v
		end
	end
end
