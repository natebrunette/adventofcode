import XCTest

func _2020_day2_part1(_ reader: Reader) -> Int {
  var count = 0
  while let line = reader.next() {
    let parts = line.components(separatedBy: " ")
    let range = parts[0].components(separatedBy: "-")
    let min = Int(range[0])!
    let max = Int(range[1])!
    let char = Character(parts[1][0])
    let password = parts[2]
    let passwordCount = password.reduce(0) { $1 == char ? $0 + 1 : $0 }

    count += passwordCount >= min && passwordCount <= max ? 1 : 0
  }

  return count
}

func _2020_day2_part2(_ reader: Reader) -> Int {
  var count = 0
  while let line = reader.next() {
    let parts = line.components(separatedBy: " ")
    let range = parts[0].components(separatedBy: "-")
    let pos1 = Int(range[0])! - 1
    let pos2 = Int(range[1])! - 1
    let character = parts[1][0]
    let password = parts[2]
    let isValid = (password[pos1] == character) ^ (password[pos2] == character)

    count += isValid ? 1 : 0
  }

  return count
}

extension Tests2020 {
  func testDay2Part1() throws {
    reader.readFile(year: 2020, day: 2)
    XCTAssertEqual(640, _2020_day2_part1(reader))
  }
  func testDay2Part2() throws {
    reader.readFile(year: 2020, day: 2)
    XCTAssertEqual(472, _2020_day2_part2(reader))
  }
}
