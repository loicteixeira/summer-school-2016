require "spec_helper"

describe "Graph#breadth_first_traversal" do
	it "should yield nodes in breadth first traversal" do
		g = Graph[
			[1, 2],
			[3],
			[3],
			[],
		]
		expect { |p|
			g.breadth_first_traversal(0, &p)
		}.to yield_successive_args(0, 1, 2, 3)
	end
end

describe "Graph#depth_first_traversal" do
	it "should yield nodes in depth first traversal" do
		g = Graph[
			[1, 2],
			[3],
			[3],
			[],
		]
		expect { |p|
			g.depth_first_traversal(0, &p)
		}.to yield_successive_args(0, 1, 3, 2)
	end
end

describe "Graph#cyclic?" do
	it "should return false for graph with no cycles" do
		g = Graph[
			[1, 2],
			[2],
			[],
		]
		z = g.cyclic?
		expect(z).to eql(false)
	end

	it "should return false for graph with no cycles" do
		g = Graph[
			[],
			[0],
			[0, 1],
		]
		z = g.cyclic?
		expect(z).to eql(false)
	end

	it "should return true for graph with cycle" do
		g = Graph[
			[],
			[0, 2],
			[0, 1],
		]
		z = g.cyclic?
		expect(z).to eql(true)
	end
end

describe "Graph#topological_sort" do
	it "should yield nodes in topological sort" do
		g = Graph[
			[1, 2],
			[2],
			[],
		]
		expect { |p|
			g.topological_sort(&p)
		}.to yield_successive_args(2, 1, 0)
	end

	it "should yield nodes in topological sort" do
		g = Graph[
			[],
			[0],
			[0, 1],
		]
		expect { |p|
			g.topological_sort(&p)
		}.to yield_successive_args(0, 1, 2)
	end

	it "should raise CyclicError for graph with cycle" do
		g = Graph[
			[],
			[0, 2],
			[0, 1],
		]
		expect {
			g.topological_sort { |i| }
		}.to raise_error(Graph::CyclicError)
	end
end
