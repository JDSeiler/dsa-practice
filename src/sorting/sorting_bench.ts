import bubbleSort from "./bubble_sort/main.ts";
import { randArrayOfSize } from "./common.ts";
import insertionSort from "./insertion_sort/main.ts";

// Maybe expand to do benchmarks across a range of input sizes.
// These random arrays are different each time the *entire file* is evaluated.
const LARGE_INPUT = randArrayOfSize(10000, { lower: 0, upper: 8000 });

Deno.bench("insertionSort", { group: "insertion_sort", baseline: true }, () => {
  const input = [...LARGE_INPUT];
  insertionSort(input);
});

Deno.bench("Array#sort", { group: "insertion_sort" }, () => {
  const input = [...LARGE_INPUT];
  input.sort();
});

Deno.bench("bubbleSort", { group: "bubble_sort", baseline: true }, () => {
  const input = [...LARGE_INPUT];
  bubbleSort(input);
});

Deno.bench("Array#sort", { group: "bubble_sort" }, () => {
  const input = [...LARGE_INPUT];
  input.sort();
});

Deno.bench("selectionSort", { group: "selection_sort", baseline: true }, () => {
  const input = [...LARGE_INPUT];
  bubbleSort(input);
});

Deno.bench("Array#sort", { group: "selection_sort" }, () => {
  const input = [...LARGE_INPUT];
  input.sort();
});