import XCTest

func _2020_day11_part1(_ reader: Reader) -> Int {
  reader.readFile(year: 2020, day: 11)

  let graph = buildPlaneGraph(reader: reader, limit: 1)

  return countOccupiedSeats(graph: graph, tolerance: 4)
}

func _2020_day11_part2(_ reader: Reader) -> Int {
  reader.readFile(year: 2020, day: 11)

  let graph = buildPlaneGraph(reader: reader)

  return countOccupiedSeats(graph: graph, tolerance: 5)
}

private enum PlaneSeat: String, CustomStringConvertible {
  case empty = "L"
  case occupied = "#"
  case none = "."

  var description: String { self.rawValue }
}

private func buildPlaneGraph(reader: Reader, limit: Int? = nil) -> Graph<PlaneSeat> {
  let lines = reader.nextBlock()!.map { $0.map { PlaneSeat(rawValue: String($0))! } }
  var graph = Graph<PlaneSeat>()
  let until = limit == nil ? Int.max : limit!
  let numRows = lines.count
  let numCols = lines[0].count
  let directions = Direction.directions + Direction.diagonals

  for row in 0..<numRows {
    for col in 0..<numCols {
      let value = lines[row][col]
      if value == .none {
        continue
      }

      let node = Graph.Node(row, col, value)

      for direction in directions {
        var iteration = 0
        var newRow = row
        var newCol = col

        while iteration++ < until {
          newRow += direction.row
          newCol += direction.col

          if newRow < 0 || newCol < 0 || newRow >= numRows || newCol >= numCols {
            break
          }

          if lines[newRow][newCol] != .none {
            graph.add(Graph.Node(newRow, newCol, lines[newRow][newCol]), to: node)
            break
          }
        }
      }
    }
  }

  return graph
}

private func countOccupiedSeats(graph: Graph<PlaneSeat>, tolerance: Int) -> Int {
  var occupied = graph.findNodes { $0.value == .occupied }
  var changed = true
  while changed {
    changed = false
    var visibleOccupiedSeats = [Graph<PlaneSeat>.Node: Int]()
    occupied.forEach { node in
      graph.get(node).forEach {
        visibleOccupiedSeats[$0, default: 0]++
      }
    }

    occupied = [Graph<PlaneSeat>.Node]()
    graph.nodes().forEach { node in
      if node.value == .occupied && visibleOccupiedSeats[node, default: 0] >= tolerance {
        changed = true
        node.value = .empty
      }

      if node.value == .empty && visibleOccupiedSeats[node, default: 0] == 0 {
        changed = true
        node.value = .occupied
      }

      if node.value == .occupied {
        occupied.append(node)
      }
    }
  }

  return occupied.count
}

extension Tests2020 {
  func testDay11part1() throws {
    reader.readFile(year: 2020, day: 11)
    XCTAssertEqual(2275, _2020_day11_part1(reader))
  }
  func testDay11part2() throws {
    reader.readFile(year: 2020, day: 11)
    XCTAssertEqual(2121, _2020_day11_part2(reader))
  }
}
