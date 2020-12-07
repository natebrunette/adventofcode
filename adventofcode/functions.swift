func twoSum(nums: [Int], target: Int) -> [Int] {
  var map = [Int: Int]()
  for (i, num) in nums.enumerated() {
    let complement = target - num

    if map[complement] != nil {
      return [map[complement]!, i]
    }

    map[num] = i
  }

  return [0]
}

func threeSum(nums: [Int], target: Int) -> [Int] {
  let sortedNums = nums.sorted()

  for i in nums.indices where i < sortedNums.count - 2 {
    var left = i + 1
    var right = sortedNums.count - 1

    while left < right {
      let sum = sortedNums[i] + sortedNums[left] + sortedNums[right]
      if sum < target {
        left++
      } else if sum > target {
        right--
      } else {
        return [sortedNums[i], sortedNums[left], sortedNums[right]]
      }
    }
  }

  return [0]
}

enum Comparison {
  case lt
  case gt
  case eq
}

func binarySearch<T: Comparable>(coll: [T], low: Int, high: Int, target: T) -> Int {
  return binarySearchClosure(coll: coll, low: low, high: high) { item in
    if target < item {
      return .lt
    } else if target > item {
      return .gt
    } else {
      return .eq
    }
  }
}

func binarySearchClosure<T>(coll: [T], low: Int, high: Int, callback: (T) -> Comparison) -> Int {
  let mid = low + ((high - low) / 2)
  switch callback(coll[mid]) {
  case .lt:
    return binarySearchClosure(coll: coll, low: low, high: mid - 1, callback: callback)
  case .gt:
    return binarySearchClosure(coll: coll, low: mid + 1, high: high, callback: callback)
  case .eq:
    return mid
  }
}
