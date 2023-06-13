import { assert, assertEquals } from "testing/asserts.ts";
import { describe, it } from "testing/bdd.ts";
import { isSorted, randArrayOfSize } from "./common.ts";
import insertionSort from "./insertion_sort/main.ts";
import bubbleSort from "./bubble_sort/main.ts";
import selectionSort from "./selection_sort/main.ts";

type TestCase = StaticTestCase | DynamicTestCase;
interface StaticTestCase {
  type: "static";
  name: string;
  input: number[];
  expected: number[];
}

interface DynamicTestCase {
  type: "dynamic";
  name: string;
  input: number[];
}

const COMMON_TEST_CASES: TestCase[] = [
  {
    type: "static",
    name: "Works on the empty list",
    input: [],
    expected: [],
  },
  {
    type: "static",
    name: "Works on list with one element",
    input: [42],
    expected: [42],
  },
  {
    type: "static",
    name: "Works on 2-element list",
    input: [100, 50],
    expected: [50, 100],
  },
  {
    type: "static",
    name: "Works on a descending order list",
    input: [10, 9, 8, 7, 6, 5, 4, 3, 2, 1],
    expected: [1, 2, 3, 4, 5,6 , 7, 8, 9, 10],
  },
  {
    type: "dynamic",
    name: "Works on medium list",
    input: randArrayOfSize(15, { lower: -10, upper: 10 }),
  },
  {
    type: "dynamic",
    name: "Works on a large list",
    input: randArrayOfSize(150, { lower: -300, upper: 300 }),
  },
  {
    type: "dynamic",
    name: "Works on a large list with many duplicates",
    input: randArrayOfSize(150, { lower: -10, upper: 10 }),
  },
  {
    type: "static",
    name: "Works on a sorted list",
    input: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    expected: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
  },
];

const ALGORITHMS: Record<string, (a: number[]) => number[]> = {
  "Insertion Sort": insertionSort,
  "Bubble Sort": bubbleSort,
  "Selection Sort": selectionSort,
};

const executeCommonTests = () => {
  Object.entries(ALGORITHMS).forEach(([name, sortFn]) => {
    describe(name, () => {
      COMMON_TEST_CASES.forEach((testCase) => {
        // Maybe simplify all the tests to use isSorted? Kinda nice to be able to hard code expected results.
        if (testCase.type === "static") {
          it(testCase.name, () => {
            // make a copy so that tests don't interfere!
            const inputCopy = [...testCase.input]
            const actual = sortFn(inputCopy);
            assertEquals(actual, testCase.expected, testCase.name);
          });
        } else {
          it(testCase.name, () => {
            const inputCopy = [...testCase.input]
            const actual = sortFn(inputCopy);
            assert(isSorted(actual));
          });
        }
      });
    });
  });
};

executeCommonTests();
