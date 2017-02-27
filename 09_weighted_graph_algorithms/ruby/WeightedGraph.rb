#
# This class implements a directed weighted graph:
#
#   https://en.wikipedia.org/wiki/Graph_(abstract_data_type)
#
# A graph has one field:
#
#   `@m` is the memory for the elements.
#
## <>
##   @m: Memory<Memory<[Integer, Float]>>
class WeightedGraph
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
		#   g = WeightedGraph[
		#     {1 => 1.0, 2 => 1.0},
		#     {2 => 1.0},
		#     {},
		#   ]
		#
		## *Hash<Integer, Float> -> WeightedGraph
		def [](*rows)
			n = rows.size
			rows.each do |row|
				row.each do |j, _|
					if j < 0 || j >= n
						raise ArgumentError.new("index out of bounds for #{n}: #{j}")
					end
				end
			end
			m = Memory.new(n) { |i|
				Memory[*rows.fetch(i)]
			}
			return WeightedGraph.__new__(m)
		end
	end

	#
	# `initialize`
	#   is called by the VM for a new graph.
	#
	## Memory<Memory<[Integer, Float]>> -> void
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
	#   g = WeightedGraph[
	#     {1 => 1.0, 2 => 1.0},
	#     {2 => 1.0},
	#     {},
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
	#   g = WeightedGraph[
	#     {1 => 1.0, 2 => 1.0},
	#     {2 => 1.0},
	#     {},
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
	#   g = WeightedGraph[
	#     {1 => 1.0, 2 => 1.0},
	#     {2 => 1.0},
	#     {},
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
	#   g = WeightedGraph[
	#     {1 => 1.0, 2 => 1.0},
	#     {2 => 1.0},
	#     {},
	#   ]
	#   g.each_edge(0) # yields [1, 1.0], [2, 1.0]
	#
	## Integer, &{[Integer, Float] -> void} -> void
	def each_edge(i, &block)
		__assert_bounds(i)
		__each_edge(i, &block)
		return
	end

	## Integer, &{[Integer, Float] -> void} -> void
	def __each_edge(i, &block)
		m = @m[i]
		c = m.capacity
		c.times do |k|
			yield m[k]
		end
		return
	end

	## <>
	##   @i: Integer
	class NodeItem < BinaryHeap::Item
		## Float, Integer -> void
		def initialize(priority, i)
			super(priority)
			@i = i
			return
		end

		attr_reader :i
	end

	#
	# `dijkstra`
	#   yields the shortest distances to each node from node `k`.
	#
	# Example:
	#
	#   g = WeightedGraph[
	#     {1 => 2.0, 2 => 7.0},
	#     {2 => 3.0},
	#     {0 => 1.0},
	#   ]
	#   g.dijkstra(0) # => yields [0, 0.0], [1, 2.0], [2, 5.0]
	#
	# Write about 25 lines of code for this method.
	#
	## Integer, &{Integer, Float -> void} -> void
	def dijkstra(k)
		raise NotImplementedError
	end

	#
	# `adjacency_matrix`
	#   returns adjacency matrix for graph.
	#
	# Example:
	#   g = WeightedGraph[
	#     {1 => 2.0, 2 => 7.0},
	#     {2 => 3.0},
	#     {0 => 1.0},
	#   ]
	#   g.adjacency_matrix # =>
	#     Memory[
	#       Memory[0.0, 2.0, 7.0],
	#       Memory[Float::INFINITY, 0.0, 3.0],
	#       Memory[1.0, Float::INFINITY, 0.0],
	#     ]
	#
	# Write about 10 lines of code for this method.
	#
	## -> Memory<Memory<Float>>
	def adjacency_matrix
		raise NotImplementedError
	end

	#
	# `floyd_warshall`
	#   returns shortest distances from each node to each node.
	#
	# Example:
	#
	#   g = WeightedGraph[
	#     {1 => 2.0, 2 => 7.0},
	#     {2 => 3.0},
	#     {0 => 1.0},
	#   ]
	#   g.floyd_warshall # =>
	#     Memory[
	#       Memory[0.0, 2.0, 5.0],
	#       Memory[4.0, 0.0, 3.0],
	#       Memory[1.0, 3.0, 0.0],
	#     ]
	#
	# Write about 10 lines of code for this method.
	#
	## -> Memory<Memory<Float>>
	def floyd_warshall
		raise NotImplementedError
	end

	## <>
	##   @i: Integer
	##   @j: Integer?
	class EdgeItem < BinaryHeap::Item
		## Float, Integer -> void
		def initialize(priority, i)
			super(priority)
			@i = i
			@j = nil
			return
		end

		attr_reader :i
		attr_accessor :j
	end

	#
	# `prim`
	#   yields edges of a minimum spanning tree for undirected graph.
	#
	# Example:
	#
	#   g = WeightedGraph[
	#     {1 => 2.0, 2 => 7.0},
	#     {0 => 2.0, 2 => 3.0},
	#     {0 => 7.0, 1 => 3.0},
	#   ]
	#   g.prim(0) # yields [0, 1], [1, 2]
	#
	# Write about 30 lines of code for this method.
	#
	## Integer, &{Integer, Integer -> void} -> void
	def prim(k)
		raise NotImplementedError
	end
end
