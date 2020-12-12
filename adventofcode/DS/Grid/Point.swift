struct Point {
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

  static func + (point: Point, direction: Direction) -> Point {
    Point(point.x + direction.x, point.y + direction.y)
  }

  static func += (point: inout Point, direction: Direction) {
    point = point + direction
  }
}
