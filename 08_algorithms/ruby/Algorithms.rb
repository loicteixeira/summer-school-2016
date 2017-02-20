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
			n = m0.capacity
			m1 = Memory.new(n)
			n.times do |j|
				i = r.rand(j + 1)
				if i != j
					m1[j] = m1[i]
				end
				m1[i] = m0[j]
			end
			return m1
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
			j = m.capacity
			while j > 1
				i = r.rand(j)
				j -= 1
				if i != j
					swap(m, i, j)
				end
			end
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
			i = 0
			j = m.capacity
			while i < j
				k = (i + j) / 2
				ek = m[k]
				if ek == e
					return true
				elsif ek > e
					j = k
				elsif ek < e
					i = k + 1
				else
					raise RuntimeError.new("incomparable: #{ek} <=> #{e}")
				end
			end
			return false
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
			n = word.capacity
			unless n >= 2
				raise ArgumentError.new("expected n >= 2 but was #{n}")
			end
			table = Memory.new(n)
			table[1] = 0
			i = 0
			j = 1
			while j + 1 < n
				if word[i].eql?(word[j])
					i += 1
					j += 1
					table[j] = i
				elsif i != 0
					i = table[i]
				else
					j += 1
					table[j] = i
				end
			end
			return table
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
			n = word.capacity
			table = kmp_table(word)
			i = 0
			j = 0
			while j < m.capacity
				if word[i].eql?(m[j])
					j += 1
					i += 1
					if i == n
						yield j - n
						i = 0
					end
				elsif i != 0
					i = table[i]
				else
					j += 1
				end
			end
			return
		end
	end
end
