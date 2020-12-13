import XCTest

func _2020_day9_part1(_ reader: Reader) -> Int {
  let lines = reader.nextBlock()!.asInt()
  let preamble = 25
  for i in preamble..<lines.count {
    if twoSum(nums: Array(lines[i - preamble..<i]), target: lines[i]) == [] {
      return lines[i]
    }
  }

  return 0
}

func _2020_day9_part2(_ reader: Reader) -> Int {
  let lines = reader.nextBlock()!.asInt()
  reader.replay()
  let target = _2020_day9_part1(reader)

  var left = 0
  var right = 1
  var count = lines[left] + lines[right]

  while count != target {
    if count > target {
      count -= lines[left++]
    } else {
      count += lines[++right]
    }
  }

  let range = lines[left...right]

  return range.min()! + range.max()!
}

extension Tests2020 {
  func testDay9Part1() throws {
    reader.readFile(year: 2020, day: 9)
    XCTAssertEqual(26_134_589, _2020_day9_part1(reader))
  }
  func testDay9Part2() throws {
    reader.readFile(year: 2020, day: 9)
    XCTAssertEqual(3_535_124, _2020_day9_part2(reader))
  }
}
