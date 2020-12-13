import XCTest

func _2020_day3_part1(_ reader: Reader) -> Int {
  countTrees(grid: buildTobogganGrid(reader: reader), right: 3, down: 1)
}

func _2020_day3_part2(_ reader: Reader) -> Int {
  let coords = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  let grid = buildTobogganGrid(reader: reader)
  let result = coords.reduce(1) { $0 * countTrees(grid: grid, right: $1[0], down: $1[1]) }

  return result
}

private func buildTobogganGrid(reader: Reader) -> [[String.Element]] {
  var grid = [[Character]]()
  var x = 0

  while let line = reader.next() {
    grid.append([Character](repeating: ".", count: line.count))
    line.enumerated().forEach { grid[x][$0] = $1 }
    x++
  }

  return grid
}

private func countTrees(grid: [[String.Element]], right: Int, down: Int) -> Int {
  var x = 0
  var y = 0
  var count = 0
  let numRows = grid.count
  let numCols = grid[0].count

  while x < numRows {
    if y >= numCols {
      y -= numCols
    }

    if grid[x][y] == "#" {
      count++
    }

    x += down
    y += right
  }

  return count
}

extension Tests2020 {
  func testDay3Part1() throws {
    reader.readFile(year: 2020, day: 3)
    XCTAssertEqual(272, _2020_day3_part1(reader))
  }
  func testDay3Part2() throws {
    reader.readFile(year: 2020, day: 3)
    XCTAssertEqual(3_898_725_600, _2020_day3_part2(reader))
  }
}
