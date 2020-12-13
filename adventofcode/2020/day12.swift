import XCTest

func _2020_day12_part1(_ reader: Reader) -> Int {
  var location = Point(0, 0)
  var facing = Facing.east

  while let line = reader.next() {
    let dir = NavigationAction(rawValue: line[0])!
    let amount = Int(line[1...])!
    switch dir {
    case .right:
      facing = facing.turn(.right, amount: amount)
    case .left:
      facing = facing.turn(.left, amount: amount)
    case .north:
      location.move(.north, times: amount)
    case .east:
      location.move(.east, times: amount)
    case .south:
      location.move(.south, times: amount)
    case .west:
      location.move(.west, times: amount)
    case .forward:
      switch facing {
      case .north:
        location.move(.north, times: amount)
      case .east:
        location.move(.east, times: amount)
      case .south:
        location.move(.south, times: amount)
      case .west:
        location.move(.west, times: amount)
      }
    }
  }

  return location.distance(from: Point(0, 0))
}

func _2020_day12_part2(_ reader: Reader) -> Int {
  var location = Point(0, 0)
  var waypoint = Point(10, -1)

  while let line = reader.next() {
    let dir = NavigationAction(rawValue: line[0])!
    let amount = Int(line[1...])!
    switch dir {
    case .right:
      waypoint.rotate90(around: location, degrees: amount)
    case .left:
      waypoint.rotate90(around: location, degrees: -amount)
    case .north:
      waypoint.move(.north, times: amount)
    case .east:
      waypoint.move(.east, times: amount)
    case .south:
      waypoint.move(.south, times: amount)
    case .west:
      waypoint.move(.west, times: amount)
    case .forward:
      let distance = location.relativeDistance(to: waypoint)
      location.move(distance: distance, times: amount)
      waypoint.move(distance: distance, times: amount)
    }
  }

  return location.distance(from: Point(0, 0))
}

private enum NavigationAction: String {
  case right = "R"
  case left = "L"
  case north = "N"
  case east = "E"
  case south = "S"
  case west = "W"
  case forward = "F"
}

private enum Facing: Int {
  enum Turn { case right, left }

  case north = 0
  case east = 90
  case south = 180
  case west = 270

  func turn(_ direction: Turn, amount: Int) -> Facing {
    switch direction {
    case .right:
      return Facing(rawValue: (self.rawValue + amount) % 360)!
    case .left:
      return Facing(rawValue: (self.rawValue + (360 - amount)) % 360)!
    }
  }
}

extension Tests2020 {
  func testDay12part2() throws {
    reader.readFile(year: 2020, day: 12)
    XCTAssertEqual(63843, _2020_day12_part2(reader))
  }
  func testDay12part1() throws {
    reader.readFile(year: 2020, day: 12)
    XCTAssertEqual(1496, _2020_day12_part1(reader))
  }
}
