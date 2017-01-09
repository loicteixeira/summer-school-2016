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

	#
	# This module defines utility methods.
	#
	## <>
	module Util
		class << self
			#
			# `join`
			#   joins subtrees `left_node` and `right_node`
			#   and returns root node of the result, if any,
			#   or `nil` otherwise.
			#
			# Write about 20 lines of code for this method.
			#
			## Node<E>?, Node<E>? -> Node<E>?
			def join(left_node, right_node)
				if left_node.nil?
					return right_node
				end
				node = left_node.right_node
				if node.nil?
					left_node.right_node = right_node
					return left_node
				end
				parent_node = left_node
				while true
					child_node = node.right_node
					if child_node.nil?
						parent_node.right_node = node.left_node
						node.left_node = left_node
						node.right_node = right_node
						return node
					end
					parent_node = node
					node = child_node
				end
			end

			#
			# `replace`
			#   returns node to replace `node`.
			#
			## Node<E> -> Node<E>?
			def replace(node)
				return join(node.left_node, node.right_node)
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
	# Write about 25 lines of code for this method.
	#
	## E -> void
	def add(e)
		node = @root_node
		if node.nil?
			@root_node = Node.new(e)
			return
		end
		while true
			if node.e == e
				return
			elsif node.e > e
				left_node = node.left_node
				if left_node.nil?
					node.left_node = Node.new(e)
					return
				end
				node = left_node
			elsif node.e < e
				right_node = node.right_node
				if right_node.nil?
					node.right_node = Node.new(e)
					return
				end
				node = right_node
			else
				raise RuntimeError
			end
		end
	end

	#
	# `delete`
	#   removes element `e` from the tree.
	#
	# Example:
	#
	#   t = BinarySearchTree.root(2) { right(3) }
	#   t.delete(3)
	#
	# Write about 30 lines of code for this method.
	#
	## E -> void
	def delete(e)
		node = @root_node
		if node.nil?
			return
		end
		if node.e == e
			@root_node = Util.replace(node)
			return
		end
		while true
			if node.e == e
				raise RuntimeError
			elsif node.e > e
				left_node = node.left_node
				if left_node.nil?
					return
				end
				if left_node.e == e
					node.left_node = Util.replace(left_node)
					return
				end
				node = left_node
			elsif node.e < e
				right_node = node.right_node
				if right_node.nil?
					return
				end
				if right_node.e == e
					node.right_node = Util.replace(right_node)
					return
				end
				node = right_node
			else
				raise RuntimeError
			end
		end
	end

	#
	# `delete_min`
	#   returns the smallest element, if any,
	#   (and removes the element in that case)
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   t = BinarySearchTree.root(3) { left(2) }
	#   t.delete_min # => 2
	#
	# Write about 20 lines of code for this method.
	#
	## -> E?
	def delete_min
		root_node = @root_node
		if root_node.nil?
			return nil
		end
		node = root_node.left_node
		if node.nil?
			@root_node = root_node.right_node
			return root_node.e
		end
		parent_node = root_node
		while true
			child_node = node.left_node
			if child_node.nil?
				parent_node.left_node = node.right_node
				return node.e
			end
			parent_node = node
			node = child_node
		end
	end

	#
	# `find_min`
	#   returns the smallest element, if any,
	#   or `nil` otherwise.
	#
	# Example:
	#
	#   t = BinarySearchTree.root(3) { left(2) }
	#   t.find_min # => 2
	#
	# Write about 10 lines of code for this method.
	#
	## -> E?
	def find_min
		node = @root_node
		if node.nil?
			return nil
		end
		while true
			child_node = node.left_node
			if child_node.nil?
				return node.e
			end
			node = child_node
		end
	end

	#
	# `member?`
	#   returns whether the tree contains element `e`.
	#
	# Example:
	#
	#   t = BinarySearchTree.root(2)
	#   t.member?(3) # => false
	#
	# Write about 10 lines of code for this method.
	#
	## E -> boolean
	def member?(e)
		node = @root_node
		until node.nil?
			if node.e == e
				return true
			elsif node.e > e
				node = node.left_node
			elsif node.e < e
				node = node.right_node
			else
				raise RuntimeError
			end
		end
		return false
	end
end
