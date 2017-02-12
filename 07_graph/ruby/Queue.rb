## <E: ..Object?>
##   @n: Integer
##   @head_node: Node<E>?
##   @last_node: Node<E>?
class Queue
	## <E: ..Object?>
	##   @e: E
	##   @tail_node: Node<E>?
	class Node
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
		## <E: ..Object?> *E -> Queue<E>
		def [](*values)
			n = values.size
			i = n
			unless i > 0
				return Queue.__new__(n, nil, nil)
			end
			i -= 1
			e = values.fetch(i)
			last_node = Node.new(e, nil)
			head_node = last_node
			while i > 0
				i -= 1
				e = values.fetch(i)
				head_node = Node.new(e, head_node)
			end
			return Queue.__new__(n, head_node, last_node)
		end
	end

	## Integer, Node<E>?, Node<E>? -> void
	def initialize(n, head_node, last_node)
		super()
		@n = n
		@head_node = head_node
		@last_node = last_node
		return
	end

	## ..Object? -> boolean
	def eql?(o)
		if o.is_a?(Queue)
			if @n == o.size
				node = @head_node
				o.each do |e|
					if node.nil?
						raise RuntimeError.new("concurrent modification")
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

	## -> Integer
	def size
		return @n
	end

	## -> E?
	def shift
		head_node = @head_node
		if head_node.nil?
			return nil
		end
		@n -= 1
		if @last_node.equal?(head_node)
			@last_node = nil
		end
		@head_node = head_node.tail_node
		return head_node.e
	end

	## E -> void
	def push(e)
		node = Node.new(e, nil)
		last_node = @last_node
		if last_node.nil?
			@head_node = node
			@last_node = node
			return
		end
		last_node.tail_node = node
		@last_node = node
		@n += 1
		return
	end
end
