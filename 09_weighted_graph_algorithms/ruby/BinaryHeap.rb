## <E: ..Comparable<*/E>>
##   @m: Memory<E>
##   @n: Integer
class BinaryHeap
	## <>
	##   @index: Integer?
	##   @priority: Float
	class Item
		## <Item>
		include Comparable

		## Float -> void
		def initialize(priority)
			super()
			@index = nil
			@priority = priority
			return
		end

		attr_accessor :index
		attr_accessor :priority

		## Item -> Integer
		def <=>(other)
			return @priority <=> other.priority
		end
	end

	module Util
		class << self
			## <E: ..Comparable<*/E>> Memory<E>, Integer, E -> void
			def __set(m, i, e)
				m[i] = e
				e.index = i
				return
			end

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
					__set(m, j, ei)
					j = i
					if j == 0
						break
					end
				end
				return j
			end

			## <E: ..Comparable<*/E>> Memory<E>, Integer, Integer, E -> Integer
			def sift_down(m, n, i, e)
				unless n >= i * 2 + 3
					raise RuntimeError.new("expected n >= #{i * 2 + 3} but was #{n}")
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
						__set(m, i, ej)
						i = j
					else
						if e <= ek
							break
						end
						__set(m, i, ek)
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
						__set(m, i, ej)
						i = j
						break
					end
				end
				return i
			end

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
						__set(m, i, ej)
						i = j
					else
						__set(m, i, ek)
						i = k
					end
					j = i * 2 + 1
					k = i * 2 + 2
					if k > n
						break
					end
					ej = m[j]
					if k == n
						__set(m, i, ej)
						i = j
						break
					end
				end
				return i
			end
		end
	end

	class << self
		## Integer -> BinaryHeap
		def new(c)
			m = Memory.new(c)
			return BinaryHeap.__new__(m, 0)
		end

		## <E: ..Comparable<*/E>> *E -> BinaryHeap<E>
		def [](*values)
			m = Memory[*values]
			return BinaryHeap.__new__(m, values.size)
		end
	end

	## Memory<E>, Integer -> void
	def initialize(m, n)
		super()
		@m = m
		@n = n
		return
	end

	## Integer -> E
	def __get(i)
		return @m[i]
	end

	## Integer, E -> void
	def __set(i, e)
		Util.__set(@m, i, e)
		return
	end

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

	## -> Integer
	def size
		return @n
	end

	## -> boolean
	def empty?
		return @n.zero?
	end

	## -> boolean
	def full?
		return @n == @m.capacity
	end

	## -> E?
	def first
		if empty?
			return nil
		end
		return @m[0]
	end

	## E -> void
	def add(e)
		if full?
			raise IndexError.new("heap is full")
		end
		n = @n
		@n = n + 1
		if n.zero?
			__set(0, e)
			return
		end
		i = Util.sift_up(@m, n, e)
		__set(i, e)
		return
	end

	## -> E?
	def shift
		if empty?
			return nil
		end
		e = @m[0]
		e.index = nil
		n = @n - 1
		case n
		when 0
			# ...
		when 1
			__set(0, @m[1])
		when 2
			e1 = @m[1]
			e2 = @m[2]
			if e1 < e2
				__set(0, e1)
				__set(1, e2)
			else
				__set(0, e2)
			end
		else
			en = @m[n]
#			i = Util.sift_down(@m, n, 0, en)
			i = Util.sift_up(@m, Util.sift_down_full(@m, n), en)
			__set(i, en)
		end
		@m[n] = nil
		@n = n
		return e
	end

	## E -> void
	def sift_up(e)
		j = e.index
		if j.nil?
			raise ArgumentError.new("not in heap")
		end
		if j != 0
			i = Util.sift_up(@m, j, e)
			if i != j
				__set(i, e)
			end
		end
		return
	end
end
