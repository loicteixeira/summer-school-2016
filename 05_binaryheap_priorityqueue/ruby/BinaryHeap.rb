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
				unless j >= 1
					raise RuntimeError.new("expected j >= 1 but was #{j}")
				end
				while true
					i = (j - 1) / 2
					ei = m[i]
					unless e < ei
						break
					end
					m[j] = ei
					j = i
					if j == 0
						break
					end
				end
				return j
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
				unless n >= 3
					raise RuntimeError.new("expected n >= 3 but was #{n}")
				end
				j = i * 2 + 1
				k = i * 2 + 2
				ej = m[j]
				while true
					ek = m[k]
					if ej < ek
						if e <= ej
							break
						end
						m[i] = ej
						i = j
					else
						if e <= ek
							break
						end
						m[i] = ek
						i = k
					end
					j = i * 2 + 1
					k = i * 2 + 2
					if k > n
						break
					end
					ej = m[j]
					if k == n
						if e <= ej
							break
						end
						m[i] = ej
						i = j
						break
					end
				end
				return i
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
				unless n >= 3
					raise RuntimeError.new("expected n >= 3 but was #{n}")
				end
				i = 0
				j = 1
				k = 2
				ej = m[j]
				while true
					ek = m[k]
					if ej < ek
						m[i] = ej
						i = j
					else
						m[i] = ek
						i = k
					end
					j = i * 2 + 1
					k = i * 2 + 2
					if k > n
						break
					end
					ej = m[j]
					if k == n
						m[i] = ej
						i = j
						break
					end
				end
				return i
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
		if empty?
			return nil
		end
		return @m[0]
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
		if full?
			raise IndexError.new("heap is full")
		end
		n = @n
		@n = n + 1
		if n.zero?
			@m[0] = e
			return
		end
		i = Util.sift_up(@m, n, e)
		@m[i] = e
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
	#   h = BinaryHeap[2, 3]
	#   h.shift # => 2
	#
	# Write about 30 lines of code for this method.
	#
	## -> E?
	def shift
		if empty?
			return nil
		end
		e = @m[0]
		n = @n - 1
		case n
		when 0
			# ...
		when 1
			@m[0] = @m[1]
		when 2
			e1 = @m[1]
			e2 = @m[2]
			if e1 < e2
				@m[0] = e1
				@m[1] = e2
			else
				@m[0] = e2
			end
		else
			en = @m[n]
#			i = Util.sift_down(@m, n, 0, en)
			i = Util.sift_up(@m, Util.sift_down_full(@m, n), en)
			@m[i] = en
		end
		@m[n] = nil
		@n = n
		return e
	end
end
