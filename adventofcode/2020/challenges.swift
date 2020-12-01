import Foundation

let reader = Reader()

func _2020_day1_part2() {
  reader.readFile(year: 2020, day: 1)
  print(threeSum(nums: reader.nextLine() as [Int], target: reader.nextLine() as Int))
}

func _2020_day1_part1() {
  reader.readFile(year: 2020, day: 1)
  print(twoSum(nums: reader.nextLine() as [Int], target: reader.nextLine() as Int))
}
