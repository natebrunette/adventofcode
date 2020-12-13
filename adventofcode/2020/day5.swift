import XCTest

func _2020_day5_part1(_ reader: Reader) -> Int {
  getSeatIdBounds(reader).high
}

func _2020_day5_part2(_ reader: Reader) -> Int {
  let bounds = getSeatIdBounds(reader)
  var set = Set<Int>(bounds.low...bounds.high)

  reader.replay()

  while let line: String = reader.next() {
    let characters = Array(line)
    let row = searchInPartition(num: 128, partitions: Array(characters[..<7]))
    let col = searchInPartition(num: 8, partitions: Array(characters[7...]))
    set.remove(row * 8 + col)
  }

  return set.first!
}

private func getSeatIdBounds(_ reader: Reader) -> (low: Int, high: Int) {
  var highest = Int.min
  var lowest = Int.max

  while let line = reader.next() {
    let characters = Array(line)
    let row = searchInPartition(num: 128, partitions: Array(characters[..<7]))
    let col = searchInPartition(num: 8, partitions: Array(characters[7...]))
    highest = max(highest, (row * 8 + col))
    lowest = min(lowest, (row * 8 + col))
  }

  return (lowest, highest)
}

private func searchInPartition(num: Int, partitions: [Character]) -> Int {
  let callback = buildSearchCallback(partitions)
  let range = Array(0..<num)

  return binarySearchClosure(coll: range, low: 0, high: num - 1, callback: callback)
}

private func buildSearchCallback(_ characters: [Character]) -> (Int) -> Comparison {
  var stack = Array(characters.reversed())

  return { (x: Int) -> Comparison in
    switch stack.popLast() {
    case "F", "L":
      return .lt
    case "B", "R":
      return .gt
    default:
      return .eq
    }
  }
}

extension Tests2020 {
  func testDay5Part1() throws {
    reader.readFile(year: 2020, day: 5)
    XCTAssertEqual(906, _2020_day5_part1(reader))
  }
  func testDay5Part2() throws {
    reader.readFile(year: 2020, day: 5)
    XCTAssertEqual(519, _2020_day5_part2(reader))
  }
}
