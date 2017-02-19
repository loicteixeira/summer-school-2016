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

			n.times do |i|
				j = r.rand(i + 1)
				m1[i] = m1[j] if i != j
				m1[j] = m0[i]
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
			n = m.capacity - 1
			n.downto 0 do |i|
				j = r.rand(i + 1)
				swap(m, j, i) if i != j
			end
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
			l, r = 0, m.capacity - 1

			loop do
				return false if l > r

				i = (l + r) / 2
				return true if m[i] == e

				if m[i] < e
					l = i + 1
				else
					r = i - 1
				end
			end
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
			t = Memory.new(n)
			pos = 2
			i = 0

			t[0] = nil
			t[1] = 0

			while pos < n do
				if word[pos - 1] == word[i]
					t[pos] = i + 1
					i += 1
					pos += 1
				elsif i > 0
					i = t[i]
				else
					t[pos] = 0
					pos += 1
				end
			end

			return t
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
		def kmp_search(word, string)
			m = 0
			i = 0
			t = kmp_table(word)

			while m + i < string.capacity do
				if word[i] == string[m + i]
					yield m if i == word.capacity - 1
					i += 1
				else
					unless t.nil?
						m += 1
						i = 0
					else
						m = m + i - t[i]
						i = t[i]
					end
				end
			end
		end
	end
end
