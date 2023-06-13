import linearSearch from "../linear_search/main.ts";
import { binarySearchRecursive, binarySearchLooping } from "./main.ts";

const BIG_ARRAY: number[] = [];
const BIG_ARRAY_SIZE = 2000000
for (let i=0; i<=BIG_ARRAY_SIZE; i++) {
  if (i % 2 === 0) {
    BIG_ARRAY.push(i);
  }
}

/*
For large-ish arrays (2 million elements):
Array#indexOf is freakishly fast *until* the array becomes very large (20 million elements)
at which point something happens and performance degrades. At 2 million elements the performance
is comparable to the binary search implementations, but a bit slower.

Plain ole' linear search is better than findIndex. Presumably because function
calls are expensive. This is further evidenced by the looping variant of binary
search being ~25% faster. All by removing literally just a few dozen function calls.

For small arrays (under 200,000!!):
Array#indexOf is, again, freakishly fast. Way faster than the alternatives.
It's not clear if this is native code speedup, or if it has some very clever algorithm.

**SUSPICION**
I think the custom binary search may perform much better if we were searching over an array
of objects instead of an array of integers. I think an array of integers will get more significant
native code speedup compared to objects.
*/

Deno.bench("binarySearchRecursive", { group: "binarySearch" }, () => {
  const randomQuery = Math.floor(Math.random() * BIG_ARRAY_SIZE);
  binarySearchRecursive(BIG_ARRAY, randomQuery);
});

Deno.bench("binarySearchLooping", { group: "binarySearch" }, () => {
  const randomQuery = Math.floor(Math.random() * BIG_ARRAY_SIZE);
  binarySearchLooping(BIG_ARRAY, randomQuery);
});

Deno.bench("Array#findIndex", { group: "binarySearch" }, () => {
  const randomQuery = Math.floor(Math.random() * BIG_ARRAY_SIZE);
  BIG_ARRAY.findIndex((value) => randomQuery === value);
});

Deno.bench("Array#indexOf", { group: "binarySearch" }, () => {
  const randomQuery = Math.floor(Math.random() * BIG_ARRAY_SIZE);
  BIG_ARRAY.indexOf(randomQuery);
});

Deno.bench("linearSearch", { group: "binarySearch" }, () => {
  const randomQuery = Math.floor(Math.random() * BIG_ARRAY_SIZE);
  linearSearch(BIG_ARRAY, randomQuery);
});
