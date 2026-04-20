#import "../lib.typ": *
#import emoji: hands

#set page(paper: "a4", flipped: true, margin: 1cm)
#set text(font: "New Computer Modern Sans", size: 11pt)
// #set text(font: "New Computer Modern Math", size: 11pt)

#let jstr(body: str) = { raw(body, lang: "Java") }

#show: cheatsheet.with(
  title: "CS2040S Finals",
  authors: "chuanhao01",
  write-title: true,
  font-size: 7pt,
  line-skip: 1.5pt,
  margin: (x: 0.6cm, y: 0.6cm),
  num-columns: 4,
  column-gutter: 4pt,
)

= Big O hierarchy
Big $O()$ hierarchy, for any constants $a, b, c, d$, $log^a (n) < n^b < 2^(c n) < n! < n^(d n)$ \
$O(c) < O(log log n) < O(log^c n) < O(n^(0 "to" 1))) < O(n) < O(n^c) < O(2^(c n)) < O(n!) < n^(c n)$

== Partitioning

Main idea, we pick an element to be the pivot(example was arr[0]).
We then iterate through the array with 2 indexes, i and j starting at 0.
We check the `arr[i+1]` with `arr[0]`.
If `arr[i+1] >= arr[0]` increment i, else `arr[i+1] < arr[0]` we swap `arr[i+1]` and `arr[j+1]`, then increment j and i.
When `i` reaches the end of the array, we then swap `arr[0]` with `arr[j]`
`j` is the boundary between the left and `j+1` ownwards are the greater elements.

Invariants:
- `arr[1..j]` is `<` smaller than the pivot
- `arr[j+1..n-1]` is `>=` greater then or equal than the pivot
- When we swap `arr[j]` and `arr[0]` we will still maintaint the invariant

#strong[Time Complexity]:
Should be $O(n)$ since in the upper bound, we iterate through all elements in the array for the comparisons.

== Insertion Sort

Invariants:
- At each iteration, arr[0, i) is sorted
- Intialise i = 1, iterate from 1 to n

The idea is that at each iteration, from 0 to n, we focus on the sub-array arr[0..i] and assume that arr[0..i-1] is sorted.
We can show that it is sorted for base case 0 and 1 elements.
From then on we will swap the arr[i] element to the left until its correct spot in the array.
That is why the condition is that iterating from j = i to 1, if arr[j-1] > arr[j] we swap, and if not we can stop the inner loop and increment i.

#strong[Time complexity]: $O(n^2)$.
Upper bounded by worse case, every new element has to be checked and shifted back i times, leading to the AP of 1 to $n$.

#strong[Space complexity]: $O(1)$.
Since no extra space is needed, besides a few known variables to keep track of the indexes.

#strong[Stability]: Stable.

== Selection Sort

Invariants:
- arr[0..i] has the same elements as the sorted array at each iteration
- After iterating to n, the whole array is sorted

The idea is to split the array into left and right, with the left having the elements being the same as the sorted array.
We can notice that to find the next element in the sorted array going left to right, we only ever need to find the minimum in the remaining numbers.
We then swap the arr[i] and arr[min], and increment i to continue.

#strong[Time Complexity]: $O(n^2)$.
This is because to find the minimum at each i, we need to look through $n-i$, leading to the AP of 1 to $n$.

#strong[Space Complexity]: $O(1)$.
Since we only need some known number of variables and we don't create any extra space.
We also swap the elements to move them into place.

It is #strong[not stable]

== Mergesort

The main idea is to always split the array into 2 halves, recursing into each sub problem.
We then split and recurse this $log(n)$ times until we reach the base case of 1 element.
We then have to spend $O(n)$ iterating through all elements atleast once to merge them into larger arrays.

Invariants
- Given 2 sorted sub lists we need to merge them back into 1 list (Merge step)
- Base case will always return a sorted list

Time Complexity: $O(n log n)$
Since we are spliting the array into halves each time, we would have $O(log n)$ splits.
At each level, we would have to iterate through all elements in the array $O(n)$ to run the merge step for each sub array in the step.
Thus $O(n)$

Space Complexity: $O(n)$
At any point, we would have to create an extra array of $O(n)$ in the worst case.
We also have the recursive stack calls of $O(log n)$

It is #strong[stable]

== Quicksort

The main idea is to pick a pivot point and parition the array into 2 halves.
We then move the pivot point into its position in the array then recurse into the left and right sub-arrays.
The base case is that we want to quicksort an array with only 1 element, in which case we return it
The sub arrays should be returned as sorted and by placing the left sub-arary, pivot and right sub-array, we get a sorted array.
To sort within the sub arrays, we pick a pivot point and create the left and right sub-arrays, with left, pivot, right split.
This is also all done in place.

Time Compleixty: $O(n^2)$ - Expected and worse case
Since we cannot guarantee the partition index, we could only parition 1 item at each recursive call leading to the recurrance formula as: $T(n) = T(n-1) + O(n)$.
This solves to $O(n^2)$

Space Compleixty: $O(n)$
We need to maintain a recursive call stack for $O(n)$ calls down.

This is #strong[not stable] due to partition

=== Quickselect

Small detour to this algo, find the largest or smallest `k`th element in an array.
If we had used the normal quicksort partition, we would end up with $O(n^2)$ since we would only remove 1 element from our search at each step with cost $O(n)$.

But with paranoid partitioning, we can always remove $1/3 n$ everytime we partition.
Hence, we do $(2/3)^i n$ cost at each $i$ step. (Steps, $0, 1, 2, 3, ...$)
This gives us the gp, $sum_(0)^(log_(3/2) n) (2/3)^i n$ giving $O(n)$

== BST

Operations
- Insert, Delete, Lookup

Without augmentation:
- Searching O(h): given a target, check current node’s key against target
- Inserting O(h): given a target, search for the immediate parent and add to the left/right depending on the target value (only add when corresponding child does not exist yet)
- Successor O(h): find node first
Deletion O(h):
1. Case 1 (leaf): delete
2. Case 2 (1 child): delete node and attach child to deleted node’s parent
3. Case 3 (2 childs): find successor of node to delete, swap the successor with
the node to delete, delete the node (now leaf)

Tree traversals O(n):
1. Pre-order: self, left, right
2. In-order: left, self, right
3. Post-order: left, right, self
4. Level-order: level by level

largest node in left st (predecessor) or smallest node in right st (successor)

== BST AVL variant

Augmenting the normal BST, with more operations and data.

The augments are:
- To add a height property to every node
- Enforce that the height difference between any left and right sub tree is atmost 1
  - `abs(root.left.height - root.right.height) == 0 or 1`

We this new invariant we can prove that to create a BST with height $h$, we need a minimum of $2^(h/2)$ nodes.
Notice the recurrance relation now:
$
  S(h) & = S(h-1) + S(h-2) \
       & + 1 ("left sub-tree + right sub-tree + root node") \
       & >= 2S(h-2) \
$
$
  S(0) = 1 \
  S(1) = 2 \
  "Strong induction on h", S(h) >= 2^(h/2) \
  S(h) >= 2S(h-2) = 2 * 2^(h/2 - 1) = 2^(h/2) qed
$

We can rearrange it to show that with $n = 2^(h/2) => 2log n = h => h = O(log n)$.
This means we needs at least $O(log n)$ nodes to create a AVL BST with height $h$.

=== Data

==== Size
We want to add a size property to every node, so that getting the size of the tree root at `node` is $O(1)$.
We do this by:
- Every time we create a node, it has size `1` by default
- Every time we insert a node, after we reassign any left or right sub-trees, we recalculate the rooted node size
  - We can do this with `root.size = root.left.size + root.right.size + 1`
  - Remember base case of $0$ for null left/right sub-trees
- Delete has the same considerations for insert, after deleting a node, recalculate the rooted node.

=== Height
We want to add a height property to every node, so we know the height of the tree at any node.
It has a definition of: $max("root.left.height", "root.right.height") + 1$.
Also all single nodes have a height of $0$.

We maintain this invariant with the insert and delete operations as such:
- When we insert a node, we have a to recalculate the height of the rooted node after insertion
- Similar for delete

Take note, when this update operation runs, it may or may not update the height.
(We could get a case we the tree left and right height is different, $h_x$ and $h_x + 1$, inserting into the $h_x$ tree does not change the height of the tree)

=== Operations

==== Rank

The main idea is to count the number of nodes smaller than you if we find the node.
Function signature looks like `rank(key)`.
We search in the BST until we find the node with `key`.
If we don't find the `key` we error.

To search,
- If `key < root.key` it means our node is in the left sub-tree, recurse into the left sub-tree
- If `key == root.key` we have found our node, return `root.left.size` (Base Case no node, it has rank 0)
- If `key > root.key` we have all the node in the `root.left.size` and `root` itself smaller than the node we are looking for.
  - Hence we return the recursed call in `root.right` + `root.left.size` + $1$

Time Complexity:
Assuming the other invariants we have later, this should run in $O(h) = O(log n)$ as we would only ever traverse the height of the tree before finding or not finding our node.
Also we are able to query the size of the node in $O(1)$ time.

Space Complexity:
Worse case we need to keep track of $O(h) = O(log n)$ recursive calls on the call stack.

=== Select

Given a "rank"(which $n^("th")$ smallest item), return the node with that rank, if it exists.
Similar to above, we search through the BST and if we do not find the element, we error.

The idea is the left sub-tree contains the $n$ smaller items, meaning the current rooted node is rank `root.left.size`.
We have 3 cases:
- $"root.left.size" == "rank"$ in which case return the `root` node
- $"root.left.size" < "rank"$, the node with our rank is larger than everything in the left sub-tree and the root node, hence we recurse in the right sub-tree with `select(root.right, rank - root.left.size - 1)`
- $"root.left.size" > "rank"$, the node with the rank we are looking for is in the left sub-tree, hence we recurse with `select(root.left, rank)`

Also note the base case, if there is no nodes in the left sub-tree, it should return a `size` of 1.
We are also only able to look for a rank if its within $0 <= "rank" <= "root.size" - 1 < "root.size"$

Time Complexity:
Should be $O(h) = O(log n)$ since we only ever iterate through the height of tree.

#image("assets/avl.png", width: 100%)

#colbreak()

== Code

#image("assets/sort-code1.png", width: 85%)
#image("assets/sort-code2.png", width: 85%)
#image("assets/sort-code3.png", width: 85%)

= AB Tree

#image("assets/AB-tree.png", width: 100%)
#image("assets/AB-tree2.png", width: 100%)

= Merkle Tree

#image("assets/merkle-tree.png", width: 90%)

= Heap
```
1. int insert(priority, value)
2. void decrease_key(int id, new_key)
3. Pair<priority, Value> extract_min_priority()
4. Pair<priority, Value> peek_min()
5. int size()
6. PQ make_pq(ArrayList<Pair<priority, Value>> array)
```

Properties: note that heaps are not BSTs
1. Heap ordering: priority[child] >= priority[parent] (min heap)
2. Complete binary tree: every level is full except possibly last
Nodes are populated from the left first

Usually start from index 1 to n (not 0 index)
- insert, decrease_key, extract_min_priority - O(log n). peek_min, size - O(1). heapify - O(n)
- Idx i: parent=i/2 (floor div), left child=2i, right child=2i+1. Idx of first empty node=heapSize+1
- 3 arrays to keep track of ID, idx, priority, value: main_arr (idx,k,v), id_to_pos (id,idx), pos_to_id
- bubble_up: swap w parent until >=parent or root. bubble_down: swap w smaller of 2 child until leaf
- Decrease_key: Update priority, bubble_up node. Insert: Insert node at end, bubble_up
- Extract_min: Swap root & last node. Remove last node. Bubble down root.
- make_pq() to make BH - bubble_down starting from size/2 (last internal node) to root

Bubble down, from a node, swap with minimum of your child, until you are smaller than your child

#image("assets/heap.png", width: 30%)

== Hashing

Collisions: two distinct keys produce the same hash function (unavoidable)

Preamble before hash tables.
For a hashing function we need it to have 3 properties:
- Always evaluate to the same output given the same input
  - `h(5) = 2` should always be the case
- If you have never seen a hashed value, it should look random
  - It should give an output with an equal probability for any output
- Should be efficient
  - Should have close to an $O(1)$ runtime.

Below, we assume this hash function exists and we can make use of it.
This is called the "SUHA", the simple uniform hashing assumption.


== Hashing and Hash Tables
We assuming we have a hashing function under "SUHA" that picks any table index uniformly at random.

Operations:
- Insert, `insert(key, value)`
- Delete, `delete(key, value)`
- Lookup, `lookup(key)`
- size, `size()`

We want all operations to have an expected runtime of $O(1)$.
We will see that the worse case for all these operations are $O(n)$.

Implementation of the hash table also depends on the collision resolution algorithm.

== Chaining

Each bucket contains a linked list of items for all items with same hash
• Total space: O(m + n) where m is the number of buckets and n is the number of entries
• Must store both the key and the value to identify when searching

- *Lookup*:
  - Worst-Case: $O(n)$
  - Expected (Under SUHA): $O(n/m)$
- *Insert*:
  - Worst-Case: $O(n)$
  - Expected (Under SUHA): $O(n/m)$
- *Delete*:
  - Worst-Case: $O(n)$
  - Expected (Under SUHA): $O(n/m)$

== Open Addressing

Open addressing: If idx already occupied, try next slot until empty found. \
Delete - when deleting item at idx, see if any item after it has hash value <= idx, and put that item into idx… repeat

== Binary Search

Binary search O(log n) \
Precondition: array is of size 𝒏, array is sorted \
Loop invariant: A[begin] <= key <= A[end] \

```
while low + 1 < high:
 mid = low + (high - low) // 2
 if arr[mid] < target:
  low = mid
 elif arr[mid] > target:
  high = mid
 else:
  return mid
```

== Additional

- Make sorting stable by using an additional array to track original indices… take O(n) space
- Use a stack to make recursion iterative, e.g. reversing a linked list

Thins we can also use: \
- stack and queues
- linked list, doublely linked list
- tries, scapegoat tree, kd-tree
- Priority Queue using a heap

#image("assets/order.png")
#image("assets/kd-tree.png")
