## <E: ..Object?>
##   @n: Integer
##   @head_node: Node<E>?
class Stack
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
		## <E: ..Object?> *E -> Stack<E>
		def [](*values)
			n = values.size
			head_node = Node.nil
			i = n
			while i > 0
				i -= 1
				e = values.fetch(i)
				head_node = Node.new(e, head_node)
			end
			return Stack.__new__(n, head_node)
		end
	end

	## Integer, Node<E>? -> void
	def initialize(n, head_node)
		super()
		@n = n
		@head_node = head_node
		return
	end

	## ..Object? -> boolean
	def eql?(o)
		if o.is_a?(Stack)
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
		@head_node = head_node.tail_node
		return head_node.e
	end

	## E -> void
	def unshift(e)
		node = Node.new(e, @head_node)
		@head_node = node
		@n += 1
		return
	end
end
