dir = File.dirname(File.expand_path(__FILE__))

require(File.join(dir, "base.rb"))

class Memory
	class Error < Exception
	end

	class << self
		def new(n)
			if n < 0
				raise Error.new("negative size: #{n}")
			end
			values = Array.new(n)
			return Memory.__new__(values)
		end

		def [](*values)
			return Memory.__new__(values)
		end
	end

	def initialize(values)
		super()
		@values = values
		return
	end

	def __assert_bounds(i)
		if i < 0 || i >= size
			raise Error.new("index out of bounds for size #{size}: #{i}")
		end
		return
	end

	def size
		return @values.size
	end

	def [](i)
		__assert_bounds(i)
		return @values[i]
	end

	def []=(i, e)
		__assert_bounds(i)
		@values[i] = e
		return
	end
end
