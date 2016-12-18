#
# This class is a re-implementation of Ruby's `Hash`:
#
#   https://docs.ruby-lang.org/en/2.0.0/Hash.html
#
# Example:
#
#   h = MyHash[2 => 0, 3 => 1]
#   h[2] # => 0
#   h[3] # => 1
#
# A hash has two fields:
#
#   `m` is the memory.
#
#   `n` is the number of elements.
#
## <K: ..Object?, V: ..Object?>
##   @m: Memory<Node<K, V>?>
##   @n: Integer
class MyHash
	#
	# This class implements a node.
	#
	# A node has three fields:
	#
	#   `k` is the key.
	#
	#   `v` is the value.
	#
	#   `tail_node` is the tail node.
	#
	## <K: ..Object?, V: ..Object?>
	##   @k: K
	##   @v: V
	##   @tail_node: Node<K, V>?
	class Node
		#
		# `initialize`
		#   is called by the VM for a new node.
		#
		## K, V, Node<K, V>?  -> void
		def initialize(k, v, tail_node)
			super()
			@k = k
			@v = v
			@tail_node = tail_node
			return
		end

		attr_reader :k
		attr_accessor :v
		attr_accessor :tail_node
	end

	class << self
		#
		# `new`
		#   returns a new hash.
		#
		# Example:
		#
		#   h = MyHash.new
		#
		## -> MyHash
		def new
			m = Memory.new(2)
			return MyHash.__new__(m, 0)
		end

		#
		# `[]`
		#   returns a new hash of the given keys and values.
		#
		# Example:
		#
		#   h = MyHash[2 => 0, 3 => 1]
		#
		## <K: ..Object?, V: ..Object?> *{K => V} -> MyHash<K, V>
		def [](kvs = {})
			c = 2
			m = Memory.new(c)
			kvs.each do |k, v|
				x = k.hash
				i = x % c
				m[i] = Node.new(k, v, m[i])
			end
			return MyHash.__new__(m, kvs.size)
		end
	end

	#
	# `initialize`
	#   is called by the VM for a new hash.
	#
	## Memory<Node<K, V>?>, Integer -> void
	def initialize(m, n)
		super()
		@m = m
		@n = n
		return
	end

	#
	# `__get`
	#   returns the node for `k`, if any,
	#   or `nil` otherwise
	#
	## ..Object? -> Node<K, V>?
	def __get(o)
		x = o.hash
		i = x % @m.capacity
		node = @m[i]
		until node.nil?
			if node.k.eql?(o)
				return node
			end
			node = node.tail_node
		end
		return nil
	end

    #
    # `eql?`
    #   returns whether the elements `eql?` the elements of `o`.
    #
    # Example:
    #
	#   h1 = MyHash[2 => 0, 3 => 1]
	#   h2 = MyHash[2 => 1, 3 => 0]
    #   h1.eql?(h2) # => false
    #
	## ..Object? -> boolean
	def eql?(o)
		if o.is_a?(MyHash)
			if @n == o.size
				o.each do |k, v|
					node = __get(k)
					if node.nil?
						return false
					end
					unless node.v.eql?(v)
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
	#   h = MyHash[2 => 0, 3 => 1]
    #   h.each do |k, v|
    #     # ...
    #   end
    #
	## &{[K, V] -> void} -> void
	def each
		c = @m.capacity
		c.times do |i|
			node = @m[i]
			until node.nil?
				yield [node.k, node.v]
				node = node.tail_node
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
	#   h = MyHash[2 => 0]
	#   h.size # => 1
	#
	## -> Integer
	def size
		return @n
	end

	#
	# `empty?`
	#   returns whether this hash is empty.
	#
	# Example:
	#
	#   h = MyHash[2 => 0]
	#   a.empty? # => false
	#
	## -> boolean
	def empty?
		return @n.zero?
	end

	#
	# `key?`
	#   returns whether this hash contains key `o`.
	#
	# Example:
	#
	#   h = MyHash[2 => 0]
	#   h.key?(2) # => true
	#
	# Write about 1 or 2 lines of code for this method.
	#
	## ..Object? -> boolean
	def key?(o)
		i = o % @m.capacity
		node = @m[i]
		until node.nil?
			return true if node.k == o
			node = node.tail_node
		end
		false
	end

	#
	# `value?`
	#   returns whether this hash contains value `o`.
	#
	# Example:
	#
	#   h = MyHash[2 => 0]
	#   h.value?(0) # => true
	#
	# Write about 6 lines of code for this method.
	#
	## ..Object? -> boolean
	def value?(o)
		@m.capacity.times do |i|
			node = @m[i]
			until node.nil?
				return true if node.v == o
				node = node.tail_node
			end
		end
		return false
	end

	#
	# `[]`
	#   returns the value corresponding to key `o`, if any,
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   h = MyHash[2 => 0]
	#   h[2] # => 0
	#
	# Write about 5 lines of code for this method.
	#
	## ..Object? -> V?
	def [](o)
		i = o % @m.capacity
		node = @m[i]
		until node.nil?
			return node.v if node.k == o
			node = node.tail_node
		end
		return
	end

	#
	# `[]=`
	#   sets the value corresponding to key `k`.
	#
	# Example:
	#
	#   h = MyHash[2 => 0]
	#   h[3] = 1
	#
	# Write about 9 lines of code for this method.
	#
	## K, V -> void
	def []=(k, v)
		node = __get(k)
		unless node.nil?
			node.v = v
			return
		end

		i = k % @m.capacity
		node = Node.new(k, v, @m[i])
		@m[i] = node
		@n += 1
	end

	#
	# `delete`
	#   returns the value corresponding to key `o`, if any,
	#   (and removes the node for that key in that case)
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   h = MyHash[2 => 0]
	#   h.delete(2) # => 0
	#
	# Write about 22 lines of code for this method.
	#
	## ..Object? -> V?
	def delete(o)
		i = o % @m.capacity

		previous_node = nil
		current_node = @m[i]
		until current_node.nil?
			if current_node.k == o
				if previous_node
					previous_node.tail_node = current_node.tail_node
				else
					@m[i] = current_node.tail_node
				end
				@n -= 1
				return current_node.v
			end
			previous_node = current_node
			current_node = current_node.tail_node
		end
	end
end
