dir = File.dirname(File.expand_path(__FILE__))

require(File.join(dir, "base.rb"))

class Memory
	class Fault < Exception
	end

	class << self
		def new(c, e = nix)
			if c < 0
				raise Fault.new("negative capacity: #{c}")
			end
			if e.nix?
				values = Array.new(c)
			else
				values = Array.new(c, e)
			end
			if block_given?
				c.times do |i|
					values[i] = yield(i)
				end
			end
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

	def __get(i)
		return @values[i]
	end

	def eql?(o)
		if o.is_a?(Memory)
			if capacity == o.capacity
				capacity.times do |i|
					unless @values[i].eql?(o.__get(i))
						return false
					end
				end
				return true
			end
		end
		return false
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
