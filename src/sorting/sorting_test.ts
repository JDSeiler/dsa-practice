import { assert, assertEquals } from "testing/asserts.ts";
import { describe, it } from "testing/bdd.ts";
import { randArrayOfSize, isSorted } from "./common.ts";
import insertionSort from "./insertion_sort/main.ts";


describe("Insertion Sort", () => {
  it("Works on the empty list", () => {
    const actual = insertionSort([]);
    assertEquals(actual, []);
  });

  it("Works on list with one element", () => {
    const actual = insertionSort([42]);
    assertEquals(actual, [42]);
  });

  it("Works on 2-element list", () => {
    const actual = insertionSort([100, 50]);

    assertEquals(actual, [50, 100]);
  });

  it("Works on medium list", () => {
    const input = randArrayOfSize(15, { lower: -10, upper: 10 });
    assert(isSorted(insertionSort(input)));
  });

  it("Works on large list", () => {
    const input = randArrayOfSize(150, { lower: -300, upper: 300 });
    assert(isSorted(insertionSort(input)));
  });

  it("Works on list with many duplicates", () => {
    const input = randArrayOfSize(150, { lower: 0, upper: 10 });
    assert(isSorted(insertionSort(input)));
  });
  
  it("Works on sorted list", () => {
    const input = [1,2,3,4,5,6,7,8,9,10];
    assert(isSorted(insertionSort(input)));
  });
});
