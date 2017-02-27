# Summer School 2016

Summer School is a course in algorithms and data structures. The course is run via the [WellingtonRuby Meetup](https://www.meetup.com/WellingtonRuby) and features weekly assignments and review sessions.

## Assignments

1. Array, Enumerable & Enumerator
  - [Source](../../commit/a01-src)
  - [Implementation](../../compare/a01-src...a01-impl)
  - [Correction](../../compare/a01-src...a01-corr)
  - [Diff](../../compare/a01-impl...a01-corr) between my implementation and the correction
  - [Notes](#01---array-enumerable--enumerator)
2. CircularBuffer & LinkedList
  - [Source](../../commit/a02-src)
  - [Implementation](../../compare/a02-src...a02-impl)
  - [Correction](../../compare/a02-src...a02-corr)
  - [Diff](../../compare/a02-impl...a02-corr) between my implementation and the correction
  - [Notes](#02---circular-buffer--linked-list)
3. Hash
  - [Source](../../commit/a03-src)
  - [Implementation](../../compare/a03-src...a03-impl)
  - [Correction](../../compare/a03-src...a03-corr)
  - [Diff](../../compare/a03-impl...a03-corr) between my implementation and the correction
  - [Notes](#03---hashes)
4. Binary Search Tree
  - [Source](../../commit/a04-src)
  - [Implementation](../../compare/a04-src...a04-impl)
  - [Correction](../../compare/a04-src...a04-corr)
  - [Diff](../../compare/a04-impl...a04-corr) between my implementation and the correction
  - [Notes](#04---binary-tree)
5. Binary Heap & Priority Queue
  - [Source](../../commit/a05-src)
  - [(Partial) Implementation](../../compare/a05-src...a05-impl)
  - [Correction](../../compare/a05-src...a05-corr)
  - [Diff](../../compare/a05-impl...a05-corr) between my implementation and the correction
  - [Notes](#05---binary-heap--priority-queue)
6. Matrix & Page Rank
  - [Source](../../commit/a06-src)
  - [Implementation](../../compare/a06-src...a06-impl)
  - [Correction](../../compare/a06-src...a06-corr)
  - [Diff](../../compare/a06-impl...a06-corr) between my implementation and the correction
  - [Notes](#06---matrix--page-rank)
7. Graph
  - [Source](../../commit/a07-src)
  - [(Partial) Implementation](../../compare/a07-src...a07-impl)
  - [Correction](../../compare/a07-src...a07-corr)
  - [Diff](../../compare/a07-impl...a07-corr) between my implementation and the correction
  - [Notes](#07---graph)
8. Algorithms
  - [Source](../../commit/a08-src)
  - [Implementation](../../compare/a08-src...a08-impl)
  - [Correction](../../compare/a08-src...a08-corr)
  - [Diff](../../compare/a08-impl...a08-corr) between my implementation and the correction
  - [Notes](#08---algorithms)
9. Weighted Graph Algorithms
  - [Source](../../commit/a09-src)
  - [Correction](../../compare/a09-src...a09-corr)
  - [Notes](#09---weighted-graph)

## Notes

### 01 - Array, Enumerable & Enumerator
When the memory has reached capacity, it needs to be extended. It is done by allocating a new memory chunk and copying all the elements to it.

If it was only extended to exactly what is needed, the next time around, it would happen again.
arithmetic series: `1 + 2 + ... + n = (n^2 + n) / 2`
geometric series: `1 + 2 + 4 + 8 + ... + 2^n = 2^(n+1) - 1`

### 02 - Circular Buffer & Linked List
Linked Lists lookup is faster than Arrays lookup if we assume:
- [Locality of reference](https://en.wikipedia.org/wiki/Locality_of_reference)
- Random access machine model where access time is constant

### 03 - Hashes
Use hash when keys are sparse or not even integer.

For non-integer keys, Ruby calls `hash` on the key to have an integer.
Ruby uses a [SipHash](https://en.wikipedia.org/wiki/SipHash) which is collision resistant but not completely secure, see [collision resolution](https://en.wikipedia.org/wiki/Hash_table#Collision_resolution).

### 04 - Binary Tree
Binary Tree: Each node has at most 2 child.
Binary Search Tree: Same but each node has a value and the left node is always smaller.

The shape of the tree is dependent on the order things are put in. Although, self adjusting/balancing trees help having a balanced tree regardless of the order in which the elements are added.

O(n^2) for insert and search if not balanced.
O(log•n) for insert and O(n•log•n) for search if balanced.

Easy in order traversal with recursive function (see `each`).

Normal implementation of `eql?` would only verify that the container has the same values in it but for the sake of this exercise, it also check the structure of the tree.

### 05 - Binary Heap & Priority Queue

Index calculations for Binary Heaps:
- In general the children of the value at index `i` are at index `2 * i + 1` and `2 * i + 2`.
- The parent of the value at index `i` is at index `(i - 1) / 2`.

Utils methods have a few preconception.
- `sift_up` assume that element at index `j` has a parent (or that `j >= 1`).
- `sift_down` assume that the element at index `i` has 2 children.

Heapsort (runtime of `n•log•n`) usually use a max-heap which will shift all values from the start and add them from the end.

### 06 - Matrix & Page Rank

#### Matrix
[1]: https://en.wikipedia.org/wiki/Vector_(mathematics)
[2]: https://en.wikipedia.org/wiki/Matrix_(mathematics)
The inner product of two [vectors][1] is the sum of the products of corresponding elements, such as `a•b = a1b1 + a2b2 + a3b3 + ...` (e.g. with `v1 = Vector[1, 2]` and `v2 = Vector[2, 3]`, `v1 • v2 = 8`).
> The straightforward algorithm for calculating a floating-point dot product of vectors can suffer from [catastrophic cancellation](https://en.wikipedia.org/wiki/Catastrophic_cancellation). To avoid this, approaches such as the [Kahan summation algorithm](https://en.wikipedia.org/wiki/Kahan_summation_algorithm) are used. – [Wikipedia](https://en.wikipedia.org/wiki/Dot_product#Algorithms)

The product of two matrices is a [matrix][2] of the inner product of each row (of the first matrix) with each column (of the second matrix).

#### Page Rank

Given the pages and links:
- A links to B
- B links to C
- C links to B and D
- D links to A

An [adjacency matrix](https://en.wikipedia.org/wiki/Adjacency_matrix) can be created to represent the pages links between each other. It will take n^2 space.
```
   A   B   C   D
A  0   1   0   0
B  0   0   1   0
C  0   1   0   1
D  1   0   0   0
```
Then it will be transformed into a (right) [stochastic matrix](https://en.wikipedia.org/wiki/Stochastic_matrix) (a.k.a. probability matrix) where each value is a non-negative real number representing a probability and where each row sums to 1. It will show the probability to go to a given page.
```
   A   B   C   D
A  0   1   0   0
B  0   0   1   0
C  0  0.5  0  0.5
D  1   0   0   0
```

> The PageRank theory holds that an imaginary surfer who is randomly clicking on links will eventually stop clicking. The probability, at any step, that the person will continue is a *damping factor* `d`. Various studies have tested different damping factors, but it is generally assumed that the damping factor will be set around 0.85. – [Wikipedia](https://en.wikipedia.org/wiki/PageRank#Damping_factor)

It then multiplies the matrix by the damping factor and saves the result.

Separately, it creates another *stochastic matrix* of the same size, filled with `1/n` representing the probability to pick a page when the surfer stops following links. This second matrix is multiplied by the opposite of the damping factor.

Both result are summed: `follow_links_matrix * d + pick_new_page_matrix * (1 - d)`.

In addition to being *stochastic*, the resulting matrix is also *irreducible* (can get anywhere from anywhere) and *aperiodic* (it's possible to be on any page at any given step).

The PageRank is finally computed using the [power iteration](https://en.wikipedia.org/wiki/Power_iteration) (an [Eigenvalue algorithm](https://en.wikipedia.org/wiki/Eigenvalue_algorithm)) which, in short, produces a non-zero vector, multiplies it by the matrix, saves the resulting vector and repeat the process with that new vector until the probability to be on any page reach [stationary distribution](https://en.wikipedia.org/wiki/Stationary_distribution).
```ruby
# With `m` the matrix and `n` the number of pages in the matrix.
v0 = Vector.new(n, 1/n)
while true
  v1 = m * v0
  t = (v1.magnitude - v0.magnitude)

  break if t < 0.0001

  v0 = v1
end
# PageRank is the value of v1
```

Note: In this exercise, it give the same weight to each link here but the importance of a link could be weighted. In addition, in case the surfer stops following links and go to another page, all the pages have an equal chance of being selected, but in reality, the surfer probably goes to a well known page.

### 07 - Graph

Representing page links with a matrix takes `n^2` space and don't have edges per se.
A more efficient way to represent the pages relations would be to use a [graph](https://en.wikipedia.org/wiki/Graph_(abstract_data_type)) of size `n + e` (nodes + edges, a.k.a. links).

Recursive methods are simpler but might cause stack overflow. Iterative methods can be used instead but then need to use a stack to keep track of where you are conceptually.

It is not possible to produce a [topological sort](https://en.wikipedia.org/wiki/Topological_sorting) if the graph is cyclic (or if a portion of it is).

Note: In this exercise, an array of size `n` is used to keep track of the visited nodes and might not be practical when the nodes not simple integers. Other solutions might involve using the hash of the object and checking whether it is in the array; or it could use a binary search tree.

### 08 - Algorithms

#### Fisher–Yates shuffle
> The Fisher–Yates shuffle is an algorithm for generating a random permutation of a finite set. [...] The algorithm effectively puts all the elements into a hat; it continually determines the next element by randomly drawing an element from the hat until no elements remain. The algorithm produces an unbiased permutation: every permutation is equally likely. – [Wikipedia](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle)

#### Binary search algorithm

[Binary search](https://en.wikipedia.org/wiki/Binary_search_algorithm) runs in at worst `O(log•n)` (i.e. *logarithmic time*).

#### Knuth–Morris–Pratt algorithm
> In computer science, the Knuth–Morris–Pratt string searching algorithm (or KMP algorithm) searches for occurrences of a word within a main text string by employing the observation that when a mismatch occurs, the word itself embodies sufficient information to determine where the next match could begin, thus bypassing re-examination of previously matched characters. – [Wikipedia](https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm)

### 09 - Weighted Graph

#### Floyd–Warshall
> The Floyd–Warshall algorithm is an algorithm for finding shortest paths in a weighted graph – [Wikipedia](https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm)

Every combination of edges is tested by incrementally improving an estimate on the shortest path between two vertices, until the estimate is optimal.

#### Dijkstra
> Dijkstra's algorithm is an algorithm for finding the shortest paths between nodes in a graph – [Wikipedia](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm)

#### Prim
> Prim's algorithm is a greedy algorithm that finds a minimum spanning tree for a weighted undirected graph. This means it finds a subset of the edges that forms a tree that includes every vertex, where the total weight of all the edges in the tree is minimized. The algorithm operates by building this tree one vertex at a time, from an arbitrary starting vertex, at each step adding the cheapest possible connection from the tree to another vertex – [Wikipedia](https://en.wikipedia.org/wiki/Prim%27s_algorithm)

### Annex

#### Big O notation
> In computer science, big O notation is used to classify algorithms according to how their running time or space requirements grow as the input size grows. – [Wikipedia](https://en.wikipedia.org/wiki/Big_O_notation)

Running time | Name
--- | ---
O(1) | constant time
O(log•n) | logarithmic time
O(n) | linear time
O(n•log•n) | linearithmic time
O(n^2) | quadratic time
O(n^3) | cubic time

#### Random
Most default implementation of random are only pseudo-random and Ruby's `Random` is no different, although it also has `SecureRandom`.
