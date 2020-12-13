import XCTest

func _2020_day8_part1(_ reader: Reader) -> Int {
  var visited = Set<Int>()
  var accumulated = 0
  let instructions = reader.nextBlock()!.map { Instruction.parse($0) }
  var i = 0
  while i < instructions.count {
    if visited.contains(i) {
      break
    }

    let instruction = instructions[i]
    switch instruction.type {
    case .acc:
      accumulated += instruction.amount
      i++
    case .jmp:
      visited.insert(i)
      i += instruction.amount
    case .nop:
      i++
    }
  }

  return accumulated
}

func _2020_day8_part2(_ reader: Reader) -> Int {
  let instructions = reader.nextBlock()!.map { Instruction.parse($0) }
  var visited = Set<Int>()

  return GameConsole(instructions: instructions).run(0, 0, &visited)!
}

extension Tests2020 {
  func testDay8Part1() throws {
    reader.readFile(year: 2020, day: 8)
    XCTAssertEqual(1867, _2020_day8_part1(reader))
  }
  func testDay8Part2() throws {
    reader.readFile(year: 2020, day: 8)
    XCTAssertEqual(1303, _2020_day8_part2(reader))
  }
}
