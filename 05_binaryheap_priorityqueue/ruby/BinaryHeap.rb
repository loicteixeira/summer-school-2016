#
# This class implements a binary heap:
#
#   https://en.wikipedia.org/wiki/Binary_heap
#
# A heap has two fields:
#
#   `@m` is the memory for the elements.
#
#   `@n` is the number of elements.
#     This must be no greater than the capacity.
#
## <E: ..Comparable<*/E>>
##   @m: Memory<E>
##   @n: Integer
class BinaryHeap
	#
	# This module defines utility methods.
	#
	module Util
		class << self
			#
			# `sift_up`
			#   moves elements down `m` while larger than `e`
			#   going upwards from index `j`
			#   and returns final index.
			#
			# Write about 10 lines of code for this method.
			#
			## <E: ..Comparable<*/E>> Memory<E>, Integer, E -> Integer
			def sift_up(m, j, e)
				raise NotImplementedError
			end

			#
			# `sift_down`
			#   moves elements up `m` while smaller than `e`
			#   going downwards from index `i`
			#   and returns final index.
			#
			# Write about 35 lines of code for this method.
			#
			## <E: ..Comparable<*/E>> Memory<E>, Integer, Integer, E -> Integer
			def sift_down(m, n, i, e)
				raise NotImplementedError
			end

			#
			# `sift_down_full`
			#   moves elements up `m`
			#   going downwards from the top
			#   and returns final index.
			#
			# Write about 25 lines of code for this method.
			#
			## <E: ..Comparable<*/E>> Memory<E>, Integer -> Integer
			def sift_down_full(m, n)
				raise NotImplementedError
			end
		end
	end

	class << self
		#
		# `new`
		#   returns a new heap with capacity `c`.
		#
		# Example:
		#
		#   h = BinaryHeap.new(3)
		#
		## Integer -> BinaryHeap
		def new(c)
			m = Memory.new(c)
			return BinaryHeap.__new__(m, 0)
		end

		#
		# `[]`
		#   returns a new heap of the given values.
		#
		# Example:
		#
		#   h = BinaryHeap[2, 3]
		#
		## <E: ..Comparable<*/E>> *E -> BinaryHeap<E>
		def [](*values)
			m = Memory[*values]
			return BinaryHeap.__new__(m, values.size)
		end
	end

	#
	# `initialize`
	#   is called by the VM for a new heap.
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
	# `eql?`
	#   returns whether the elements `eql?` the elements of `o`.
	#
	# Example:
	#
	#   h1 = BinaryHeap[2, 3, 5]
	#   h2 = BinaryHeap[2, 5, 3]
	#   h1.eql?(h2) # => false
	#
	## ..Object? -> boolean
	def eql?(o)
		if o.is_a?(BinaryHeap)
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
	# `size`
	#   returns the number of elements.
	#
	# Example:
	#
	#   h = BinaryHeap[2]
	#   h.size # => 1
	#
	## -> Integer
	def size
		return @n
	end

	#
	# `empty?`
	#   returns whether this heap is empty.
	#
	# Example:
	#
	#   h = BinaryHeap[2]
	#   h.empty? # => false
	#
	## -> boolean
	def empty?
		return @n.zero?
	end

	#
	# `full?`
	#   returns whether this heap is full.
	#
	# Example:
	#
	#   h = BinaryHeap.new(3)
	#   h.full? # => false
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
	#   h = BinaryHeap[2, 3]
	#   h.first # => 2
	#
	# Write about 4 lines of code for this method.
	#
	## -> E?
	def first
		raise NotImplementedError
	end

	#
	# `add`
	#   adds element `e` to the heap.
	#
	# Example:
	#
	#   h = BinaryHeap[2, 3]
	#   h.add(5)
	#
	# Write about 10 lines of code for this method.
	#
	## E -> void
	def add(e)
		raise NotImplementedError
	end

	#
	# `shift`
	#   returns the first element, if any,
	#   (and removes the element in that case)
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   h = BinaryHeap[2, 3]
	#   h.shift # => 2
	#
	# Write about 30 lines of code for this method.
	#
	## -> E?
	def shift
		raise NotImplementedError
	end
end
