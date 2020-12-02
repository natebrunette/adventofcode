func twoSum(nums: [Int], target: Int) -> Int {
  var map = [Int: Int]()
  for (i, num) in nums.enumerated() {
    let complement = target - num

    if map[complement] != nil {
      return nums[map[complement]!] * num
    }

    map[num] = i
  }

  return 0
}

func threeSum(nums: [Int], target: Int) -> Int {
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
        return sortedNums[i] * sortedNums[left] * sortedNums[right]
      }
    }
  }

  return 0
}

func validPassword2020(min: Int, max: Int, character: Character, password: String) -> Bool {
  var count = 0
  for char in password {
    if char == character {
      count++
    }
  }

  return count >= min && count <= max
}
