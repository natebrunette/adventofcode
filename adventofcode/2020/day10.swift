import XCTest

func _2020_day10_part1(_ reader: Reader) -> Int {
  let adapters = [0] + reader.nextBlock()!.asInt().sorted()
  var map = [0: 1, 3: 1]

  for i in 1..<adapters.count {
    map[adapters[i] - adapters[i - 1], default: 0] += 1
  }

  return map[1]! * map[3]!
}

func _2020_day10_part2(_ reader: Reader) -> Int {
  let adapters = [0] + reader.nextBlock()!.asInt().sorted()
  var map = [adapters[0]: 1]
  let max = adapters.max()!
  let valid = Set<Int>(adapters)

  for i in adapters[1]...max {
    guard valid.contains(i) else {
      continue
    }

    map[i] = map[i - 1, default: 0] + map[i - 2, default: 0] + map[i - 3, default: 0]
  }

  return map[max]!
}

extension Tests2020 {
  func testDay10part1() throws {
    reader.readFile(year: 2020, day: 10)
    XCTAssertEqual(2048, _2020_day10_part1(reader))
  }
  func testDay10part2() throws {
    reader.readFile(year: 2020, day: 10)
    XCTAssertEqual(1_322_306_994_176, _2020_day10_part2(reader))
  }
}
