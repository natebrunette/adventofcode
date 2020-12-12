infix operator ?=: ComparisonPrecedence

struct Grid<T: Equatable & CustomStringConvertible>: Sequence {
  private var grid = [[T]]()
  let rows: Int
  let cols: Int
  let defaultValue: T

  var debug: String {
    var out = ""
    for row in 0..<rows {
      for col in 0..<cols {
        out += self[row, col]!.description
      }
      out += "\n"
    }

    return out
  }

  init(rows: Int, cols: Int, defaultValue: T) {
    for _ in 0..<rows {
      grid.append([T](repeating: defaultValue, count: cols))
    }

    self.rows = rows
    self.cols = cols
    self.defaultValue = defaultValue
  }

  init(grid: [[T]], defaultValue: T) {
    self.grid = grid
    self.rows = grid.count
    self.cols = grid.count > 0 ? grid[0].count : 0
    self.defaultValue = defaultValue
  }

  func directions(includeDiagonals: Bool = false) -> [Direction] {
    Direction.directions + (includeDiagonals ? Direction.diagonals : [])
  }

  func find(start: Point, direction: Direction, limit: Int?, predicate: (T) -> Bool) -> Point? {
    var iterations = 0
    var next = start + direction

    while self[next] != nil {
      if predicate(self[next]!) == true {
        return next
      }

      if limit != nil && ++iterations >= limit! {
        return nil
      }

      next += direction
    }

    return nil
  }

  func makeIterator() -> GridIterator<T> {
    GridIterator(grid: self)
  }

  static func == (lhs: Grid, rhs: Grid) -> Bool {
    for point in lhs {
      if lhs[point] != rhs[point] {
        return false
      }
    }

    return true
  }

  static func != (lhs: Grid, rhs: Grid) -> Bool {
    !(lhs == rhs)
  }

  subscript(_ point: Point) -> T? {
    get {
      self[point.y, point.x]
    }

    set {
      self[point.y, point.x] = newValue
    }
  }

  subscript(row: Int) -> [T]? {
    get {
      guard validRow(row: row) else {
        return nil
      }

      return grid[row]
    }
    set {
      if validRow(row: row) {
        grid[row] = newValue!
      }
    }
  }

  subscript(_ row: Int, _ col: Int) -> T? {
    get {
      guard validIndex(row: row, col: col) else {
        return nil
      }

      return grid[row][col]
    }

    set {
      if validIndex(row: row, col: col) {
        grid[row][col] = newValue!
      }
    }
  }

  fileprivate func validPoint(_ point: Point) -> Bool {
    validIndex(row: point.row, col: point.col)
  }

  fileprivate func validIndex(row: Int, col: Int) -> Bool {
    validRow(row: row) && validCol(col: col)
  }

  fileprivate func validRow(row: Int) -> Bool {
    row >= 0 && row < rows
  }

  fileprivate func validCol(col: Int) -> Bool {
    col >= 0 && col < cols
  }
}

struct GridIterator<T: Equatable & CustomStringConvertible>: IteratorProtocol {
  let grid: Grid<T>
  var index = 0

  mutating func next() -> Point? {
    let nextRow = index / grid.cols
    let nextCol = index % grid.cols
    index++

    if nextRow >= grid.rows {
      return nil
    }

    return Point(row: nextRow, col: nextCol)
  }
}
