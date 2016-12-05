#
# This class is a re-implementation of Ruby's `Array`:
#
#   https://docs.ruby-lang.org/en/2.0.0/Array.html
#
# Example:
#
#   a = MyArray[2, 3]
#   a[0] # => 2
#   a[1] # => 3
#   a.pop # => 3
#   a.pop # => 2
#
# An array has two fields:
#
#   `@m` is the memory for the elements.
#
#   `@n` is the number of elements.
#     This may be less than or equal to the size of `@m` but never greater.
#
## <E: ..Object?>
##   @m: Memory<E>
##   @n: Integer
class MyArray
	## <E>
	include MyEnumerable

	class << self
		#
		# `new`
		#   returns a new array with initial capacity of one element.
		#
		# Example:
		#
		#   m = MyArray.new
		#
		## -> MyArray
		def new
			m = Memory.new(1)
			return MyArray.__new__(m, 0)
		end

		#
		# `[]`
		#   returns a new array of the given values.
		#
		# Example:
		#
		#   m = MyArray[2, 3]
		#
		## <E: ..Object?> *E -> MyArray<E>
		def [](*values)
			m = Memory[*values]
			return MyArray.__new__(m, values.size)
		end
	end

	#
	# `initialize`
	#   is called by the VM for a new array.
	#
	## Memory<E>, Integer -> void
	def initialize(m, n)
		super()
		@m = m
		@n = n
		return
	end

	#
	# `__get`
	#   returns element at index `i` from the memory.
	#
	## Integer -> E
	def __get(i)
		return @m[i]
	end

	#
	# `__ensure_capacity`
	#   ensures this array has capacity for `n` elements.
	#
	## Integer -> void
	def __ensure_capacity(n)
		if n > @m.size
			m = Memory.new(n + n / 2)
			@n.times do |i|
				m[i] = @m[i]
			end
			@m = m
		end
		return
	end

	#
	# `eql?`
	#   returns whether the elements `eql?` the elements of `o`.
	#
	# Example:
	#
	#   a1 = MyArray[3, 5]
	#   a2 = MyArray[5, 3]
	#   a1.eql?(a2) # => false
	#
	## ..Object? -> boolean
	def eql?(o)
		if o.is_a?(MyArray)
			if @n == o.size
				@n.times do |i|
					unless @m[i].eql?(o.__get(i))
						return false
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
	#   a = MyArray[2, 3]
	#   a.each do |e|
	#     # ...
	#   end
	#
	## &{E -> void} -> void
	def each
		@n.times do |i|
			yield @m[i]
		end
		return
	end

	#
	# `size`
	#   returns the number of elements.
	#
	# Example:
	#
	#   a = MyArray[2]
	#   a.size # => 1
	#
	## -> Integer
	def size
		return @n
	end

	#
	# `empty?`
	#   returns whether this array is empty.
	#
	# Example:
	#
	#   a = MyArray[2]
	#   a.empty? # => false
	#
	## -> boolean
	def empty?
		return @n.zero?
	end

	#
	# `[]`
	#   returns element at index `i`, if within bounds,
	#   (a negative index wraps around)
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   a = MyArray[2, 3]
	#   a[0] # => 2
	#   a[2] # => nil
	#   a[-1] # => 3
	#   a[-3] # => nil
	#
	# Write about 9 lines of code for this method.
	#
	## Integer -> E?
	def [](i)
		if i < 0
			i += @n
			if i < 0
				return nil
			end
		elsif i >= @n
			return nil
		end
		return @m[i]
	end

	#
	# `[]=`
	#   sets the element at index `i`, if within bounds,
	#   (a negative index wraps around)
	#   or raises `IndexError` otherwise.
	#
	# Example:
	#
	#   a = MyArray[2, 3]
	#   a[0] = 5
	#   a[2] = 5 # raises IndexError
	#   a[-1] = 5
	#   a[-3] = 5 # raises IndexError
	#
	# Write about 10 lines of code for this method.
	#
	## Integer, E -> void
	def []=(i, e)
		if i < 0
			i += @n
			if i < 0
				raise IndexError
			end
		elsif i >= @n
			raise IndexError
		end
		@m[i] = e
	end

	#
	# `pop`
	#   returns the last element, if any,
	#   (and removes the element in that case)
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   a = MyArray[2, 3]
	#   a.pop # => 3
	#
	# Write about 8 lines of code for this method.
	#
	## -> E?
	def pop
		if empty?
			return nil
		end

		e = @m[@n - 1]

		@m[@n - 1] = nil
		@n -= 1

		return e
	end

	#
	# `push`
	#   ensures capacity for one more element
	#   and then appends `e` to this array.
	#
	# Example:
	#
	#   a = MyArray[2, 3]
	#   a.push(5)
	#
	# Write about 4 lines of code for this method.
	#
	## E -> void
	def push(e)
		n = @n + 1
		__ensure_capacity(n)
		@m[@n] = e
		@n = n
		return
	end

	#
	# `shift`
	#   returns the first element, if any,
	#   (and removes the element in that case)
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   a = MyArray[2, 3]
	#   a.shift # => 2
	#
	# Write about 11 lines of code for this method.
	#
	## -> E?
	def shift
		if empty?
			return nil
		end

		e = @m[0]

		@n -= 1
		@n.times do |i|
			@m[i] = @m[i + 1]
		end

		@m[@n] = nil

		return e
	end

	#
	# `unshift`
	#   ensures capacity for one more element
	#   and then prepends `e` to this array.
	#
	# Example:
	#
	#   a = MyArray[2, 3]
	#   a.unshift(5)
	#
	# Write about 14 lines of code for this method.
	#
	## E -> void
	def unshift(e)
		n = @n + 1
		__ensure_capacity(n)

		@n.times do |i|
			@m[@n - i] = @m[@n - i - 1]
		end

		@m[0] = e
		@n += 1

		return
	end

	#
	# This class implements an enumerator for an array.
	#
	# An enumerator has two fields:
	#   `@a` is the array.
	#   `@i` is the index of the next element (i.e. the position).
	#     This may be less than or equal to the size of `@a` but never greater.
	#
	## <E: ..Object?>
	##  \<E>
	##   @a: MyArray<E>
	##   @i: Integer
	class EachMyEnumerator < MyEnumerator
		#
		# `initialize`
		#   is called by the VM for a new enumerator.
		#
		## MyArray<E> -> void
		def initialize(a)
			super()
			@a = a
			@i = 0
			return
		end

		#
		# `to_enum`
		#   returns a new enumerator.
		#
		## -> MyEnumerator<E>
		def to_enum
			return EachMyEnumerator.new(@a)
		end

		#
		# `peek`
		#   returns the next element, if any,
		#   or raises `StopIteration` otherwise.
		#
		# Example:
		#
		#   a = MyArray[2, 3]
		#   enum = a.to_enum
		#   enum.peek # => 2
		#   enum.peek # => 2
		#   ...
		#
		# Write about 4 lines of code for this method.
		#
		## -> E
		def peek
			if @i >= @a.size
				raise StopIteration
			end
			return @a.__get(@i)
		end

		#
		# `next`
		#   returns the next element, if any,
		#   (and advances the position in that case)
		#   or raises `StopIteration` otherwise.
		#
		# Example:
		#
		#   a = MyArray[2, 3]
		#   enum = a.to_enum
		#   enum.next # => 2
		#   enum.next # => 3
		#   enum.next # raises `StopIteration`
		#
		# Write about 3 lines of code for this method.
		#
		## -> E
		def next
			e = peek
			@i += 1
			return e
		end
	end

	#
	# `to_enum`
	#   returns a new enumerator.
	#
	## -> MyEnumerator<E>
	def to_enum
		return EachMyEnumerator.new(self)
	end
end
