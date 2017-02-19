#
# This module implements some algorithms on memory.
#
module Algorithms
	class << self
		#
		# `swap`
		#   swaps elements at index `i` and index `j`.
		#
		# Example:
		#
		#   m = Memory[2, 3, 5]
		#   Algorithms.swap(m, 1, 2)
		#
		## <E: ..Object?> Memory<E>, Integer, Integer -> void
		def swap(m, i, j)
			m[i], m[j] = m[j], m[i]
			return
		end

		#
		# `shuffle`
		#   returns new memory with elements shuffled.
		#
		# Example:
		#
		#   r = Random.new(0)
		#   m = Memory[2, 3, 5]
		#   Algorithms.shuffle(r, m) # => Memory[3, 5, 2]
		#
		# Write about 10 lines of code for this method.
		#
		## <E: ..Object?> Random, Memory<E> -> Memory<E>
		def shuffle(r, m0)
			raise NotImplementedError
		end

		#
		# `shuffle!`
		#   shuffles elements in memory.
		#
		# Example:
		#
		#   r = Random.new(0)
		#   m = Memory[2, 3, 5]
		#   Algorithms.shuffle!(r, m)
		#
		# Write about 10 lines of code for this method.
		#
		## <E: ..Object?> Random, Memory<E> -> void
		def shuffle!(r, m)
			raise NotImplementedError
			return
		end

		#
		# `binary_search`
		#   returns whether `m` contains `e`.
		#
		# Example:
		#
		#   m = Memory[2, 3, 5]
		#   Algorithms.binary_search(2) # => true
		#
		# Write about 15 lines of code for this method.
		#
		## <E: ..Comparable<*/E>> Memory<E>, E -> boolean
		def binary_search(m, e)
			raise NotImplementedError
		end

		#
		# `kmp_table`
		#   returns table for KMP search.
		#
		# Example:
		#
		#   word = Memory[2, 2, 0]
		#   Algorithms.kmp_table(word) # => Memory[nil, 0, 1]
		#
		# Write about 20 lines of code for this method.
		#
		## <E: ..Object?> Memory<E> -> Memory<Integer>
		def kmp_table(word)
			raise NotImplementedError
		end

		#
		# `kmp_search`
		#   yields each index where `m` contains `word`.
		#
		# Example:
		#
		#   word = Memory[2, 2, 3]
		#   m = Memory[2, 2, 4, 2, 2, 3]
		#   Algorithms.kmp_search(word, m) # yields 3
		#
		# Write about 20 lines of code for this method.
		#
		## <E: ..Object?> Memory<E>, Memory<E>, &{Integer -> void} -> void
		def kmp_search(word, m)
			raise NotImplementedError
		end
	end
end
