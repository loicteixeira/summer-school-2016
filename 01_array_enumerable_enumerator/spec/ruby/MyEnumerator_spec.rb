require "spec_helper"

describe "MyEnumerator#each" do
	it "should not yield for array of no elements" do
		a = MyArray[]
		enum = a.to_enum
		expect { |b|
			enum.each(&b)
		}.not_to yield_control
	end

	it "should yield each element for array of two elements" do
		a = MyArray[3, 5]
		enum = a.to_enum
		expect { |b|
			enum.each(&b)
		}.to yield_successive_args(3, 5)
	end
end
