class Bignum
	def size
		return super
	end
end

class Fixnum
	def size
		return super
	end
end

class Integer
	def hash
		return self
	end

	def size
		raise NoMethodError.new("undefined method `size' for #{self.inspect}:Integer")
	end
end
