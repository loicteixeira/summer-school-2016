#
# This class is a re-implementation of Ruby's `Enumerator`:
#
#   https://docs.ruby-lang.org/en/2.0.0/Enumerator.html
#
# Example:
#
#   a = MyArray[2, 3]
#   enum = a.to_enum
#   enum.next # => 2
#   enum.next # => 3
#   enum.next # raises StopIteration
#
# A class that extends this class should implement these methods:
#
#   `to_enum`
#     returns a new enumerator.
#
#   `peek`
#     returns the next element, if any,
#     or raises `StopIteration` otherwise.
#
#   `next`
#     returns the next element, if any,
#     (and advances the position in that case)
#     or raises `StopIteration` otherwise.
#
## <E: ..Object?>
##   #to_enum: -> MyEnumerator<E>
##   #peek: -> E
##   #next: -> E
class MyEnumerator
	## <E>
	include MyEnumerable

	#
	# `each`
	#   yields each element.
	#
	# Example:
	#
	#   a = MyArray[2, 3]
	#   enum = a.to_enum
	#   enum.each do |e|
	#     # ...
	#   end
	#
	# Write about 9 lines of code for this method.
	#
	## &{E -> void} -> void
	def each
		e = to_enum
		loop do
			yield e.next
		end
	rescue StopIteration
		return
	end
end
