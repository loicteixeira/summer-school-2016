require "spec_helper"

describe "WeightedGraph#dijkstra" do
	it "should yield distances of shortest paths" do
		g = WeightedGraph[
			{1 => 2.0, 2 => 7.0},
			{2 => 3.0},
			{0 => 1.0},
		]
		expect { |p|
			g.dijkstra(0, &p)
		}.to yield_successive_args([0, 0.0], [1, 2.0], [2, 5.0])
	end
end

describe "WeightedGraph#adjacency_matrix" do
	it "should return adjacency matrix" do
		g = WeightedGraph[
			{1 => 2.0, 2 => 7.0},
			{2 => 3.0},
			{0 => 1.0},
		]
		m = g.adjacency_matrix
		expect(m).to eql(Memory[Memory[0.0, 2.0, 7.0], Memory[Float::INFINITY, 0.0, 3.0], Memory[1.0, Float::INFINITY, 0.0]])
	end
end

describe "WeightedGraph#floyd_warshall" do
	it "should return distances of shortest paths" do
		g = WeightedGraph[
			{1 => 2.0, 2 => 7.0},
			{2 => 3.0},
			{0 => 1.0},
		]
		m = g.floyd_warshall
		expect(m).to eql(Memory[Memory[0.0, 2.0, 5.0], Memory[4.0, 0.0, 3.0], Memory[1.0, 3.0, 0.0]])
	end
end

describe "WeightedGraph#prim" do
	it "should yield edges of minimum spanning tree" do
		g = WeightedGraph[
			{1 => 1.0, 2 => 2.0},
			{0 => 1.0, 2 => 3.0, 3 => 5.0},
			{0 => 2.0, 1 => 3.0, 3 => 4.0},
			{1 => 5.0, 2 => 4.0},
		]
		expect { |p|
			g.prim(0, &p)
		}.to yield_successive_args([0, 1], [0, 2], [2, 3])
	end
end
