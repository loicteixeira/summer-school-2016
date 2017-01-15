#
# This class implements a priority queue:
#
#   https://en.wikipedia.org/wiki/Priority_queue
#
# A queue has one field:
#
#   `@h` is the binary heap.
#
## <K: ..Comparable<*/K>, V: ..Object?>
##   @h: BinaryHeap<Item<K, V>>
class PriorityQueue
	#
	# This class implements an item.
	#
	# An item has two fields:
	#
	#   `@k` is the key.
	#
	#   `@v` is the value.
	#
	## <K: ..Comparable<*/K>, V: ..Object?>
	##   @k: K
	##   @v: V
	class Item
		## <Item<K, V>>
		include Comparable

		#
		# `initialize`
		#   is called by the VM for a new item.
		#
		## K, V -> void
		def initialize(k, v)
			super()
			@k = k
			@v = v
			return
		end

		attr_reader :k, :v

		## Item<K, V> -> Integer
		def <=>(other)
			return @k <=> other.k
		end
	end

	class << self
		#
		# `new`
		#   returns a new queue with capacity `c`.
		#
		# Example:
		#
		#   q = PriorityQueue.new(3)
		#
		## Integer -> PriorityQueue
		def new(c)
			h = BinaryHeap.new(c)
			return PriorityQueue.__new__(h)
		end
	end

	#
	# `initialize`
	#   is called by the VM for a new queue.
	#
	## BinaryHeap<Item<K, V>> -> void
	def initialize(h)
		super()
		@h = h
		return
	end

	#
	# `first`
	#   returns the first pair in the queue, if any,
	#   or `nil` otherwise.
	#
	# Write about 5 lines of code for this method.
	#
	## -> [K, V]?
	def first
		raise NotImplementedError
	end

	#
	# `shift`
	#   returns the first pair in the queue, if any,
	#   (and removes the pair in that case)
	#   or `nil` otherwise.
	#
	# Write about 5 lines of code for this method.
	#
	## -> [K, V]?
	def shift
		raise NotImplementedError
	end

	#
	# `add`
	#   inserts a pair into the queue.
	#
	# Write 1 or 2 lines of code for this method.
	#
	## K, V -> void
	def add(k, v)
		raise NotImplementedError
	end
end
