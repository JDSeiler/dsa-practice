# Quicksort Explainer
The following is the heart of quicksort, as described by [CLRS](https://en.wikipedia.org/wiki/Introduction_to_Algorithms)
```rb
def _partition(arr, s, e)
  random_pivot = rand(s..e)
  _exchange(arr, random_pivot, e)

  pivot = arr[e]
  dest = s - 1
  for to_check in s..e - 1
    if arr[to_check] <= pivot
      dest += 1
      _exchange(arr, dest, to_check)
    end
  end
  _exchange(arr, dest + 1, e)
  # Location of the pivot
  dest + 1
end

def _exchange(arr, i, j)
  tmp = arr[i]
  arr[i] = arr[j]
  arr[j] = tmp
end
```
I want to explain the intuition behind the `_partition` method, since it's somewhat dense on first inspection.

The job of the `_partition` method is, given an array and the start/end indices of a subarray:
- Select an element of the subarray, called the *pivot*
- Put all the elements less than or equal to the pivot to the left
- Put all the elements greater than the pivot to the right
- Ensure that the pivote is placed such that it exactly divides the two halves
- Return the index of the pivot

## Pivot Selection
```rb
random_pivot = rand(s..e)
_exchange(arr, random_pivot, e)

pivot = arr[e]
```
In the simplest version of the algorithm, the pivot is simply the last element of the array.
This simple scheme is vulnerable to performance degredation when used on sorted input, so
instead we select a random element, swap it to the end, and then proceed with the algorithm
as normal.

There are many other pivoting schemes, all with different trade-offs.

## Partitioning
```rb
pivot = arr[e]
dest = s - 1
for to_check in s..e - 1
  if arr[to_check] <= pivot
    dest += 1
    _exchange(arr, dest, to_check)
  end
end
```
As we scan through the array, we're going to build two regions. One for the elements that
are `<=` to the pivot and one for those `>` than the pivot. The `<=` region we build
directly, and the `>` ends up getting constructed as a side-effect.

`dest` describes the end index (inclusive) of the `<=` region. `dest` starts as -1, which
indicates that the `<=` region is empty. When we encounter an element smaller-or-equal to
the pivot, we add it to the top of the `<=` region and increase `dest` appropriately.

An analogy might be that the `<=` elements are put into a "pile" or "stack" and we plop
new elements only on the top and don't touch anything lower on the pile/stack.

Once something is added to `<=`, _it is never touched again_. By the time we've done a
full scan through the array, the range `[0, dest]` contains all the elements `<=` the
pivot. The range `[dest+1, arr.len-1]` is all of the elements larger than the pivot as
well as the pivot itself, which leads to the next section
## Pivot Setting
```rb
_exchange(arr, dest + 1, e)
# Location of the pivot
dest + 1
```
Recall that the pivot element was placed at the end of the array at the beginning of
`_partition`. Now, since we know that `[dest+1, arr.len-1]` contains everything larger
than the pivot + the pivot itself, we can swap the pivot to the front of the `>` region.

The result is exactly what we want:
- The left-hand region of the array is `<=` to the pivot
- The pivot element divides the left and right-hand regions
- The right-hand region is `>` than the pivot

Since we just placed the pivot, we can return the index trivially.
