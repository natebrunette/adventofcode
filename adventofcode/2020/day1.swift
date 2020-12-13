import XCTest

func _2020_day1_part1(_ reader: Reader) -> Int {
  let nums = reader.nextBlock()!.asInt()

  return twoSum(nums: nums, target: 2020).reduce(1) { $0 * nums[$1] }
}

func _2020_day1_part2(_ reader: Reader) -> Int {
  let nums = reader.nextBlock()!.asInt()

  return threeSum(nums: nums, target: 2020).reduce(1) { $0 * $1 }
}

extension Tests2020 {
  func testDay1Part1() throws {
    reader.readFile(year: 2020, day: 1)
    XCTAssertEqual(538_464, _2020_day1_part1(reader))
  }
  func testDay1Part2() throws {
    reader.readFile(year: 2020, day: 1)
    XCTAssertEqual(278_783_190, _2020_day1_part2(reader))
  }
}
