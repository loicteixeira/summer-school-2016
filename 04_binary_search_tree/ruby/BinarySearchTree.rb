#
# This class implements a binary search tree:
#
#   https://en.wikipedia.org/wiki/Binary_search_tree
#
# Example:
#
#   t = BinarySearchTree.new
#   t.add(2)
#   t.member?(3) # => false
#
# A binary search tree has one field:
#
#   `@root_node` is the root node.
#
## <E: ..Comparable<*/E>>
##   @root_node: Node<E>?
class BinarySearchTree
	#
	# This class implements a node.
	#
	# A node has three fields:
	#
	#   `@e` is the element.
	#
	#   `@left_node` is the left node.
	#
	#   `@right_node` is the right node.
	#
	## <E: ..Comparable<*/E>>
	##   @e: E
	##   @left_node: Node<E>?
	##   @right_node: Node<E>?
	class Node
		class << self
			#
			# `new`
			#   returns a new node.
			#
			# Example:
			#
			#   node = BinarySearchTree::Node.new(2)
			#
			## <E: ..Comparable<*/E>> E, &#{Node<E> -> void}? -> Node<E>
			def new(e, &block)
				node = Node.__new__(e)
				unless block.nil?
					node.instance_eval(&block)
				end
				return node
			end
		end

		#
		# `initialize`
		#   is called by the VM for a new node.
		#
		## E -> void
		def initialize(e)
			super()
			@e = e
			@left_node = nil
			@right_node = nil
			return
		end

		attr_reader :e
		attr_accessor :left_node, :right_node

		#
		# `eql?`
		#   returns whether the elements `eql?` the elements of `o`.
		#
		# Example:
		#
		#   node1 = BinarySearchTree::Node.new(3) { right(5) }
		#   node2 = BinarySearchTree::Node.new(5) { left(3) }
		#   node1.eql?(node2) # => false
		#
		## ..Object? -> boolean
		def eql?(o)
			if o.is_a?(Node)
				unless @left_node.eql?(o.left_node)
					return false
				end
				unless @e.eql?(o.e)
					return false
				end
				unless @right_node.eql?(o.right_node)
					return false
				end
				return true
			end
			return false
		end

		#
		# `each`
		#   yields each element.
		#
		## &{E -> void} -> void
		def each(&block)
			left_node = @left_node
			unless left_node.nil?
				left_node.each(&block)
			end
			yield @e
			right_node = @right_node
			unless right_node.nil?
				right_node.each(&block)
			end
			return
		end

		#
		# `left`
		#   adds a left node.
		#
		# Example:
		#
		#   node = BinarySearchTree::Node.new(3) { left(2) }
		#
		## E, &#{Node<E> -> void} -> void
		def left(e, &block)
			@left_node = Node.new(e, &block)
			return
		end

		#
		# `right`
		#   adds a right node.
		#
		# Example:
		#
		#   node = BinarySearchTree::Node.new(3) { right(5) }
		#
		## E, &#{Node<E> -> void} -> void
		def right(e, &block)
			@right_node = Node.new(e, &block)
			return
		end
	end

	module Util
		class << self
			#
			# `replace`
			#   returns node to replace `deleted_node`.
			#
			# Write about 20 lines of code for this method.
			#
			## <E: ..Comparable<*/E>> Node<E> -> Node<E>?
			def replace(deleted_node)
				raise NotImplementedError
			end
		end
	end

	class << self
		#
		# `new`
		#   returns a new binary search tree.
		#
		# Example:
		#
		#   t = BinarySearchTree.new
		#
		## -> BinarySearchTree
		def new
			return BinarySearchTree.__new__(nil)
		end

		#
		# `root`
		#   returns a new binary search tree.
		#
		# Example:
		#
		#   t = BinarySearchTree.root(3)
		#
		## <E: ..Comparable<*/E>> E, &#{Node<E> -> void} -> BinarySearchTree<E>
		def root(e, &block)
			root_node = Node.new(e, &block)
			return BinarySearchTree.__new__(root_node)
		end
	end

	#
	# `initialize`
	#   is called by the VM for a new tree.
	#
	## Node<E>? -> void
	def initialize(root_node)
		super()
		@root_node = root_node
		return
	end

	attr_reader :root_node

	#
	# `eql?`
	#   returns whether the elements `eql?` the elements of `o`.
	#
	# Example:
	#
	#   t1 = BinarySearchTree.root(3) { right(5) }
	#   t2 = BinarySearchTree.root(5) { left(3) }
	#   t1.eql?(t2) # => false
	#
	## ..Object? -> boolean
	def eql?(o)
		if o.is_a?(BinarySearchTree)
			return @root_node.eql?(o.root_node)
		end
		return false
	end

	#
	# `each`
	#   yields each element.
	#
	# Example:
	#
	#   t = BinarySearchTree.new
	#   t.each do |e|
	#     # ...
	#   end
	#
	## &{E -> void} -> void
	def each(&block)
		root_node = @root_node
		unless root_node.nil?
			root_node.each(&block)
		end
		return
	end

	#
	# `add`
	#   adds element `e` to the tree.
	#
	# Example:
	#
	#   t = BinarySearchTree.new
	#   t.add(3)
	#
	# Write about 24 lines of code for this method.
	#
	## E -> void
	def add(e)
		raise NotImplementedError
	end

	#
	# `delete`
	#   removes element `e` from the tree.
	#
	# Example:
	#
	#   t = BinarySearchTree.new
	#   t.delete(3)
	#
	# Write about 31 lines of code for this method.
	#
	## E -> void
	def delete(e)
		raise NotImplementedError
	end

	#
	# `member?`
	#   returns whether the tree contains element `e`.
	#
	# Example:
	#
	#   t = BinarySearchTree.new
	#   t.member?(3) # => false
	#
	# Write about 11 lines of code for this method.
	#
	## E -> boolean
	def member?(e)
		raise NotImplementedError
	end
end
