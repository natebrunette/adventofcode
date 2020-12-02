let reader = Reader()

func _2020_day2_part2() {
  reader.readFile(year: 2020, day: 2)

  var count = 0
  while let line: String = reader.nextLine() {
    let parts = line.components(separatedBy: " ")
    let range = parts[0].components(separatedBy: "-")
    let pos1 = Int(range[0])! - 1
    let pos2 = Int(range[1])! - 1
    let character = parts[1][0]
    let password = parts[2]
    let isValid = (password[pos1] == character) ^ (password[pos2] == character)

    count += isValid ? 1 : 0
  }

  print(count)
}

func _2020_day2_part1() {
  reader.readFile(year: 2020, day: 2)

  var count = 0
  while let line: String = reader.nextLine() {
    let parts = line.components(separatedBy: " ")
    let range = parts[0].components(separatedBy: "-")
    let min = Int(range[0])!
    let max = Int(range[1])!
    let character = parts[1][0]
    let password = parts[2]

    count +=
      validPassword2020(min: min, max: max, character: character, password: password) ? 1 : 0
  }

  print(count)
}

func _2020_day1_part2() {
  reader.readFile(year: 2020, day: 1)
  let nums: [Int] = reader.next()!
  let target: Int = reader.next()!
  print(threeSum(nums: nums, target: target))
}

func _2020_day1_part1() {
  reader.readFile(year: 2020, day: 1)
  let nums: [Int] = reader.next()!
  let target: Int = reader.next()!
  print(twoSum(nums: nums, target: target))
}
