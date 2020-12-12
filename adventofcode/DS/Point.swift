struct Point {
  struct Distance {
    var x = 0, y = 0
  }

  var x = 0, y = 0
  var row: Int { y }
  var col: Int { x }

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }

  init(row: Int, col: Int) {
    x = col
    y = row
  }

  mutating func move(_ direction: Direction, times: Int = 1) {
    self.x += direction.x * times
    self.y += direction.y * times
  }

  mutating func move(distance: Distance, times: Int = 1) {
    self.x += distance.x * times
    self.y += distance.y * times
  }

  mutating func rotate90(around point: Point, degrees: Int) {
    for _ in 0..<abs(degrees) / 90 {
      let distance = point.relativeDistance(to: self)
      let newX = degrees < 0 ? distance.y : -distance.y
      let newY = degrees < 0 ? -distance.x : distance.x
      self.x = point.x + newX
      self.y = point.y + newY
    }
  }

  func relativeDistance(to point: Point) -> Distance {
    var distanceX = abs(point.x - x)
    var distanceY = abs(point.y - y)

    if x > point.x {
      distanceX *= -1
    }

    if y > point.y {
      distanceY *= -1
    }

    return Distance(x: distanceX, y: distanceY)
  }

  func distance(from point: Point) -> Int {
    abs(x - point.x) + abs(y - point.y)
  }

  static func + (point: Point, direction: Direction) -> Point {
    Point(point.x + direction.x, point.y + direction.y)
  }

  static func += (point: inout Point, direction: Direction) {
    point = point + direction
  }
}
