#
# This class implements a doubly linked list:
#
#   https://en.wikipedia.org/wiki/Doubly_linked_list
#
# Example:
#
#   l = DoublyLinkedList[2, 3]
#   l.shift # => 2
#   l.shift # => 3
#
# A list has three fields:
#
#   `n` is the number of elements.
#
#   `first_node` is the first node.
#
#   `last_node` is the last node.
#
## <E: ..Object?>
##   @n: Integer
##   @first_node: Node<E>?
##   @last_node: Node<E>?
class DoublyLinkedList
	#
	# This class implements a node.
	#
	# A node has three fields:
	#
	#   `e` is the element in this node.
	#
	#   `prev_node` is the previous node.
	#
	#   `next_node` is the next node.
	#
	## <E: ..Object?>
	##   @e: E
	##   @prev_node: Node<E>?
	##   @next_node: Node<E>?
	class Node
		#
		# `initialize`
		#   is called by the VM for a new node.
		#
		## E -> void
		def initialize(e)
			super()
			@e = e
			@prev_node = nil
			@next_node = nil
			return
		end

		attr_reader :e
		attr_accessor :prev_node, :next_node
	end

	class << self
		#
		# `new`
		#   returns a new list.
		#
		# Example:
		#
		#   l = DoublyLinkedList.new
		#
		## -> DoublyLinkedList
		def new
			return DoublyLinkedList.__new__(0, nil, nil)
		end

		#
		# `[]`
		#   returns a new list of the given values.
		#
		# Example:
		#
		#   l = DoublyLinkedList[2, 3]
		#
		## <E: ..Object?> *E -> DoublyLinkedList<E>
		def [](*values)
			n = values.size
			if n == 0
				return DoublyLinkedList.new
			end
			i = 0
			e = values.fetch(i)
			first_node = Node.new(e)
			last_node = first_node
			i += 1
			while i < n
				e = values.fetch(i)
				node = Node.new(e)
				node.prev_node = last_node
				last_node.next_node = node
				last_node = node
				i += 1
			end
			return DoublyLinkedList.__new__(n, first_node, last_node)
		end
	end

	#
	# `initialize`
	#   is called by the VM for a new list.
	#
	## Integer, Node<E>?, Node<E>? -> void
	def initialize(n, first_node, last_node)
		super()
		@n = n
		@first_node = first_node
		@last_node = last_node
		return
	end

	#
	# `eql?`
	#   returns whether the elements `eql?` the elements of `o`.
	#
	# Example:
	#
	#   l1 = DoublyLinkedList[3, 5]
	#   l2 = DoublyLinkedList[5, 3]
	#   l1.eql?(l2) # => false
	#
	## ..Object? -> boolean
	def eql?(o)
		if o.is_a?(DoublyLinkedList)
			if @n == o.size
				node = @first_node
				o.each do |e|
					if node.nil?
						raise RuntimeError, "concurrent modification"
					end
					unless node.e.eql?(e)
						return false
					end
					node = node.next_node
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
	#   l = DoublyLinkedList[2, 3]
	#   l.each do |e|
	#     # ...
	#   end
	#
	## &{E -> void} -> void
	def each
		node = @first_node
		while true
			if node.nil?
				break
			end
			yield node.e
			node = node.next_node
		end
		return
	end

	#
	# `size`
	#   returns the number of elements.
	#
	# Example:
	#
	#   l = DoublyLinkedList[2]
	#   l.size # => 1
	#
	## -> Integer
	def size
		return @n
	end

	#
	# `empty?`
	#   returns whether this list is empty.
	#
	# Example:
	#
	#   l = DoublyLinkedList[2]
	#   l.empty? # => false
	#
	## -> boolean
	def empty?
		return @n.zero?
	end

	#
	# `first`
	#   returns the first element, if any,
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   l = DoublyLinkedList[2, 3]
	#   l.first # => 2
	#
	# Write about 4 lines of code for this method.
	#
	## -> E?
	def first
		node = @first_node
		if node.nil?
			return nil
		end
		return node.e
	end

	#
	# `last`
	#   returns the last element, if any,
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   l = DoublyLinkedList[2, 3]
	#   l.last # => 3
	#
	# Write about 4 lines of code for this method.
	#
	## -> E?
	def last
		node = @last_node
		if node.nil?
			return nil
		end
		return node.e
	end

	#
	# `pop`
	#   returns the last element, if any,
	#   (and removes the element in that case)
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   l = DoublyLinkedList[2, 3]
	#   l.pop # => 3
	#
	# Write about 13 lines of code for this method.
	#
	## -> E?
	def pop
		node = @last_node
		if node.nil?
			return nil
		end
		@n -= 1
		prev_node = node.prev_node
		if prev_node.nil?
			@first_node = node.next_node
		else
			prev_node.next_node = nil
		end
		@last_node = prev_node
		return node.e
	end

	#
	# `push`
	#   appends `e` to this list.
	#
	# Example:
	#
	#   l = DoublyLinkedList[2, 3]
	#   l.push(5)
	#
	# Write about 10 lines of code for this method.
	#
	## E -> void
	def push(e)
		node = Node.new(e)
		prev_node = @last_node
		if prev_node.nil?
			@first_node = node
		else
			prev_node.next_node = node
			node.prev_node = prev_node
		end
		@last_node = node
		@n += 1
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
	#   l = DoublyLinkedList[2, 3]
	#   l.shift # => 2
	#
	# Write about 13 lines of code for this method.
	#
	## -> E?
	def shift
		node = @first_node
		if node.nil?
			return nil
		end
		@n -= 1
		next_node = node.next_node
		if next_node.nil?
			@last_node = node.prev_node
		else
			next_node.prev_node = nil
		end
		@first_node = next_node
		return node.e
	end

	#
	# `unshift`
	#   prepends `e` to this list.
	#
	# Example:
	#
	#   l = DoublyLinkedList[2, 3]
	#   l.unshift(5)
	#
	# Write about 10 lines of code for this method.
	#
	## E -> void
	def unshift(e)
		node = Node.new(e)
		next_node = @first_node
		if next_node.nil?
			@last_node = node
		else
			next_node.prev_node = node
			node.next_node = next_node
		end
		@first_node = node
		@n += 1
		return
	end
end
