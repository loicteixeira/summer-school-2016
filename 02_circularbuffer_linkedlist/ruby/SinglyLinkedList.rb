#
# This class implements a singly linked list:
#
#   https://en.wikipedia.org/wiki/Linked_list
#
# Example:
#
#   l = SinglyLinkedList[2, 3]
#   l.shift # => 2
#   l.shift # => 3
#
# A list has two fields:
#
#   `n` is the number of elements.
#
#   `head_node` is the head node.
#
## <E: ..Object?>
##   @n: Integer
##   @head_node: Node<E>?
class SinglyLinkedList
	#
	# This class implements a node.
	#
	# A node has two fields:
	#
	#   `e` is the element in this node.
	#
	#   `tail_node` is the tail node.
	#
	## <E: ..Object?>
	##   @e: E
	##   @tail_node: Node<E>?
	class Node
		#
		# `initialize`
		#   is called by the VM for a new node.
		#
		## E, Node<E>? -> void
		def initialize(e, tail_node)
			super()
			@e = e
			@tail_node = tail_node
			return
		end

		attr_reader :e
		attr_accessor :tail_node
	end

	class << self
		#
		# `new`
		#   returns a new list.
		#
		# Example:
		#
		#   l = SinglyLinkedList.new
		#
		## -> SinglyLinkedList
		def new
			return SinglyLinkedList.__new__(0, nil)
		end

		#
		# `[]`
		#   returns a new list of the given values.
		#
		# Example:
		#
		#   l = SinglyLinkedList[2, 3]
		#
		## <E: ..Object?> *E -> SinglyLinkedList<E>
		def [](*values)
			n = values.size
			tail_node = Node.nil
			i = n
			while i > 0
				i -= 1
				e = values.fetch(i)
				tail_node = Node.new(e, tail_node)
			end
			return SinglyLinkedList.__new__(n, tail_node)
		end
	end

	#
	# `initialize`
	#   is called by the VM for a new list.
	#
	## Integer, Node<E>? -> void
	def initialize(n, head_node)
		super()
		@n = n
		@head_node = head_node
		return
	end

	#
	# `eql?`
	#   returns whether the elements `eql?` the elements of `o`.
	#
	# Example:
	#
	#   l1 = SinglyLinkedList[3, 5]
	#   l2 = SinglyLinkedList[5, 3]
	#   l1.eql?(l2) # => false
	#
	## ..Object? -> boolean
	def eql?(o)
		if o.is_a?(SinglyLinkedList)
			if @n == o.size
				node = @head_node
				o.each do |e|
					if node.nil?
						raise RuntimeError, "concurrent modification"
					end
					unless node.e.eql?(e)
						return false
					end
					node = node.tail_node
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
	#   l = SinglyLinkedList[2, 3]
	#   l.each do |e|
	#     # ...
	#   end
	#
	## &{E -> void} -> void
	def each
		node = @head_node
		while true
			if node.nil?
				break
			end
			yield node.e
			node = node.tail_node
		end
		return
	end

	#
	# `size`
	#   returns the number of elements.
	#
	# Example:
	#
	#   l = SinglyLinkedList[2]
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
	#   l = SinglyLinkedList[2]
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
	#   l = SinglyLinkedList[2, 3]
	#   l.first # => 2
	#
	# Write about 4 lines of code for this method.
	#
	## -> E?
	def first
		node = @head_node
		if node.nil?
			return nil
		end
		return node.e
	end

	#
	# `shift`
	#   returns the first element, if any,
	#   (and removes the element in that case)
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   l = SinglyLinkedList[2, 3]
	#   l.shift # => 2
	#
	# Write about 7 lines of code for this method.
	#
	## -> E?
	def shift
		node = @head_node
		if node.nil?
			return nil
		end
		@n -= 1
		@head_node = node.tail_node
		return node.e
	end

	#
	# `unshift`
	#   prepends `e` to this list.
	#
	# Example:
	#
	#   l = SinglyLinkedList[2, 3]
	#   l.unshift(5)
	#
	# Write about 3 lines of code for this method.
	#
	## E -> void
	def unshift(e)
		node = Node.new(e, @head_node)
		@head_node = node
		@n += 1
		return
	end
end
