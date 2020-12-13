import XCTest

func _2020_day6_part1(_ reader: Reader) -> Int {
  var count = 0
  while let lines = reader.nextBlock() {
    var set = Set<Character>()
    lines.forEach { $0.forEach { set.insert($0) } }
    count += set.count
  }

  return count
}

func _2020_day6_part2(_ reader: Reader) -> Int {
  var count = 0
  while let lines = reader.nextBlock() {
    var map = [Character: Int]()
    lines.forEach { $0.forEach { map[$0, default: 0] += 1 } }
    count += map.keys.reduce(0) { map[$1] == lines.count ? $0 + 1 : $0 }
  }

  return count
}

extension Tests2020 {
  func testDay6Part1() throws {
    reader.readFile(year: 2020, day: 6)
    XCTAssertEqual(6504, _2020_day6_part1(reader))
  }
  func testDay6Part2() throws {
    reader.readFile(year: 2020, day: 6)
    XCTAssertEqual(3351, _2020_day6_part2(reader))
  }
}
