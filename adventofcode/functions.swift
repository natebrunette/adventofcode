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

func validPassword2020(pos1: Int, pos2: Int, character: Character, password: String) -> Bool {
  let first = password[String.Index(utf16Offset: pos1 - 1, in: password)]
  let second = password[String.Index(utf16Offset: pos2 - 1, in: password)]

  return (first == character) ^ (second == character)
}
