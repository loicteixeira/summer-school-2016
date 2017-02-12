#
# This class implements a directed unweighted graph:
#
#   https://en.wikipedia.org/wiki/Graph_(abstract_data_type)
#
# A graph has one field:
#
#   `@m` is the memory for the edges.
#
## <>
##   @m: Memory<Memory<Integer>>
class Graph
	class CyclicError < StandardError
	end

	class << self
		## -> void
		def new
			raise RuntimeError.new
		end

		#
		# `[]`
		#   returns a new graph with the given edges.
		#
		# Example:
		#
		#   g = Graph[
		#     [1, 2],
		#     [2],
		#     [],
		#   ]
		#
		## *Array<Integer> -> Graph
		def [](*rows)
			n = rows.size
			rows.each do |row|
				row.each do |j|
					if j < 0 || j >= n
						raise ArgumentError.new("index out of bounds for #{n}: #{j}")
					end
				end
			end
			m = Memory.new(n) { |i|
				Memory[*rows.fetch(i)]
			}
			return Graph.__new__(m)
		end
	end

	#
	# `initialize`
	#   is called by the VM for a new array.
	#
	## Memory<Memory<Integer>> -> void
	def initialize(m)
		super()
		@m = m
		return
	end

	#
	# `__assert_bounds`
	#   asserts index `i` is within bounds.
	#
	## Integer -> void
	def __assert_bounds(i)
		if i < 0 || i >= size
			raise IndexError.new("index out of bounds for #{size}: #{i}")
		end
		return
	end

	#
	# `size`
	#   returns number of nodes in this graph.
	#
	# Example:
	#
	#   g = Graph[
	#     [1, 2],
	#     [2],
	#     [],
	#   ]
	#   g.size # => 3
	#
	## -> Integer
	def size
		return @m.capacity
	end

	#
	# `empty?`
	#   returns whether this graph has no nodes.
	#
	# Example:
	#
	#   g = Graph[
	#     [1, 2],
	#     [2],
	#     [],
	#   ]
	#   g.empty? # => false
	#
	## -> boolean
	def empty?
		return size.zero?
	end

	#
	# `edge_count`
	#   returns number of edges from node `i`.
	#
	# Example:
	#
	#   g = Graph[
	#     [1, 2],
	#     [2],
	#     [],
	#   ]
	#   g.edge_count(0) # => 2
	#
	## Integer -> Integer
	def edge_count(i)
		__assert_bounds(i)
		return __edge_count(i)
	end

	## Integer -> Integer
	def __edge_count(i)
		return @m[i].capacity
	end

	#
	# `each_edge`
	#   yields each node with an edge from node `i`.
	#
	# Example:
	#
	#   g = Graph[
	#     [1, 2],
	#     [2],
	#     [],
	#   ]
	#   g.each_edge(0) # yields 1, 2
	#
	## Integer, &{Integer -> void} -> void
	def each_edge(i, &block)
		__assert_bounds(i)
		__each_edge(i, &block)
		return
	end

	## Integer, &{Integer -> void} -> void
	def __each_edge(i)
		m = @m[i]
		c = m.capacity
		c.times do |k|
			yield m[k]
		end
		return
	end

	#
	# `reverse_each_edge`
	#   yields each node with an edge from node `i`.
	#
	# Example:
	#
	#   g = Graph[
	#     [1, 2],
	#     [2],
	#     [],
	#   ]
	#   g.reverse_each_edge(0) # yields 2, 1
	#
	## Integer, &{Integer -> void} -> void
	def reverse_each_edge(i, &block)
		__assert_bounds(i)
		__reverse_each_edge(i, &block)
		return
	end

	## Integer, &{Integer -> void} -> void
	def __reverse_each_edge(i)
		m = @m[i]
		c = m.capacity
		while c > 0
			c -= 1
			yield m[c]
		end
		return
	end

	#
	# `breadth_first_traversal`
	#   yields nodes in breadth first traversal starting from node `k`.
	#
	# Example:
	#
	#   g = Graph[
	#     [1, 2],
	#     [3],
	#     [3],
	#     [],
	#   ]
	#   g.breadth_first_traversal(0) # yields 0, 1, 2, 3
	#
	# Write about 15 lines of code for this method.
	#
	## Integer, &{Integer -> void} -> void
	def breadth_first_traversal(k)
		__assert_bounds(k)
		visited = Memory.new(size, false)
		queue = Queue[k]
		loop do
			i = queue.shift
			return if i.nil?
			yield i
			__each_edge(i) do |j|
				unless visited[j]
					visited[j] = true
					queue.push(j)
				end
			end
		end
	end

	#
	# `depth_first_traversal`
	#   yields nodes in depth first traversal starting from node `k`.
	#
	# Example:
	#
	#   g = Graph[
	#     [1, 2],
	#     [3],
	#     [3],
	#     [],
	#   ]
	#   g.depth_first_traversal(0) # yields 0, 1, 3, 2
	#
	# Write about 15 lines of code for this method.
	#
	## Integer, &{Integer -> void} -> void
	def depth_first_traversal(k)
		__assert_bounds(k)
		visited = Memory.new(size, false)
		stack = Stack[k]
		loop do
			i = stack.shift
			return if i.nil?
			yield i
			__reverse_each_edge(i) do |j|
				unless visited[j]
					visited[j] = true
					stack.unshift(j)
				end
			end
		end
	end

	#
	# `cyclic?`
	#   returns whether the graph has a cycle.
	#
	# Example:
	#
	#   g = Graph[
	#     [1, 2],
	#     [2],
	#     [],
	#   ]
	#   g.cyclic? # => false
	#
	## -> boolean
	def cyclic?
		label = Memory.new(size, :new)
		size.times do |i|
			case label[i]
			when :new
				if __cyclic_iterative?(label, i)
#				if __cyclic_recursive?(label, i)
					return true
				end
			when :processing
				raise RuntimeError.new
			when :visited
				# ...
			else
				raise RuntimeError.new
			end
		end
		return false
	end

	#
	# `__cyclic_iterative?`
	#   returns whether the component with node `k` has a cycle.
	#
	# Write about 25 lines of code for this method.
	#
	## Memory<Symbol>, Integer -> boolean
	def __cyclic_iterative?(label, k)
		raise NotImplementedError
	end

	#
	# `__cyclic_recursive?`
	#   returns whether the component with node `i` has a cycle.
	#
	# Write about 15 lines of code for this method.
	#
	## Memory<Symbol>, Integer -> boolean
	def __cyclic_recursive?(label, i)
		raise NotImplementedError
	end

	#
	# `topological_sort`
	#   yields nodes in topological sort.
	#
	# Example:
	#
	#   g = Graph[
	#     [1, 2],
	#     [2],
	#     [],
	#   ]
	#   g.topological_sort # yields 2, 1, 0
	#
	## &{Integer -> void} -> void
	def topological_sort(&block)
		label = Memory.new(size, :new)
		size.times do |i|
			case label[i]
			when :new
				__topological_sort_iterative(label, i, &block)
#				__topological_sort_recursive(label, i, &block)
			when :processing
				raise RuntimeError.new
			when :visited
				# ...
			else
				raise RuntimeError.new
			end
		end
		return
	end

	#
	# `__topological_sort_iterative`
	#   yields nodes in component with node `k`.
	#
	# Write about 25 lines of code for this method.
	#
	## Memory<Symbol>, Integer, &{Integer -> void} -> void
	def __topological_sort_iterative(label, k)
		raise NotImplementedError
	end

	#
	# `__topological_sort_recursive`
	#   yields nodes in component with node `k`.
	#
	# Write about 15 lines of code for this method.
	#
	## Memory<Symbol>, Integer, &{Integer -> void} -> void
	def __topological_sort_recursive(label, i, &block)
		raise NotImplementedError
	end
end
