import bubbleSort from "./bubble_sort/main.ts";
import { randArrayOfSize } from "./common.ts";
import insertionSort from "./insertion_sort/main.ts";
import mergeSort from "./merge_sort/main.ts";

// Maybe expand to do benchmarks across a range of input sizes.
// These random arrays are different each time the *entire file* is evaluated.
const LARGE_INPUT = randArrayOfSize(20000, { lower: 0, upper: 8000 });

// Deno uses V8 under the hood. So unless V8 has been updated, Array#sort is 
// using Timsort under the hood: https://v8.dev/blog/array-sort
// Timsort was developed for python. The author describes it here:
// https://github.com/python/cpython/blob/main/Objects/listsort.txt
//
// No matter what, I don't think any user-land sorting algorithm will beat
// something that's part of the V8 internals, especially for integer sorting.

Deno.bench("insertionSort", { group: "insertionSort", baseline: true }, () => {
  const input = [...LARGE_INPUT];
  insertionSort(input);
});

Deno.bench("Array#sort", { group: "insertionSort" }, () => {
  const input = [...LARGE_INPUT];
  input.sort();
});

Deno.bench("bubbleSort", { group: "bubbleSort", baseline: true }, () => {
  const input = [...LARGE_INPUT];
  bubbleSort(input);
});

Deno.bench("Array#sort", { group: "bubbleSort" }, () => {
  const input = [...LARGE_INPUT];
  input.sort();
});

Deno.bench("selectionSort", { group: "selectionSort", baseline: true }, () => {
  const input = [...LARGE_INPUT];
  bubbleSort(input);
});

Deno.bench("Array#sort", { group: "selectionSort" }, () => {
  const input = [...LARGE_INPUT];
  input.sort();
});

Deno.bench("mergeSort", { group: "mergeSort", baseline: true }, () => {
  const input = [...LARGE_INPUT];
  mergeSort(input);
});

Deno.bench("Array#sort", { group: "mergeSort" }, () => {
  const input = [...LARGE_INPUT];
  input.sort();
});