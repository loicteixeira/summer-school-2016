dir = File.dirname(File.expand_path(__FILE__))

require(File.join(dir, "base.rb"))

class Memory
	class Fault < Exception
	end

	class << self
		def new(c)
			if c < 0
				raise Fault.new("negative capacity: #{c}")
			end
			values = Array.new(c)
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
		if i < 0 || i >= capacity
			raise Fault.new("index out of bounds for capacity #{capacity}: #{i}")
		end
		return
	end

	def capacity
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
