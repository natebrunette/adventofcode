let reader = Reader()

func _2020_day12_part2() -> Int {
  reader.readFile(year: 2020, day: 12)

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

func _2020_day12_part1() -> Int {
  reader.readFile(year: 2020, day: 12)

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

func _2020_day11_part2() -> Int {
  reader.readFile(year: 2020, day: 11)

  let graph = buildPlaneGraph(reader: reader)

  return countOccupiedSeats(graph: graph, tolerance: 5)
}

func _2020_day11_part1() -> Int {
  reader.readFile(year: 2020, day: 11)

  let graph = buildPlaneGraph(reader: reader, limit: 1)

  return countOccupiedSeats(graph: graph, tolerance: 4)
}

func _2020_day10_part2() -> Int {
  reader.readFile(year: 2020, day: 10)

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

func _2020_day10_part1() -> Int {
  reader.readFile(year: 2020, day: 10)

  let adapters = [0] + reader.nextBlock()!.asInt().sorted()
  var map = [0: 1, 3: 1]

  for i in 1..<adapters.count {
    map[adapters[i] - adapters[i - 1], default: 0] += 1
  }

  return map[1]! * map[3]!
}

func _2020_day9_part2() -> Int {
  reader.readFile(year: 2020, day: 9)

  let lines = reader.nextBlock()!.asInt()
  let target = _2020_day9_part1()

  var left = 0
  var right = 1
  var count = lines[left] + lines[right]

  while count != target {
    if count > target {
      count -= lines[left++]
    } else {
      count += lines[++right]
    }
  }

  let range = lines[left...right]

  return range.min()! + range.max()!
}

func _2020_day9_part1() -> Int {
  reader.readFile(year: 2020, day: 9)

  let lines = reader.nextBlock()!.asInt()
  let preamble = 25
  for i in preamble..<lines.count {
    if twoSum(nums: Array(lines[i - preamble..<i]), target: lines[i]) == [] {
      return lines[i]
    }
  }

  return 0
}

func _2020_day8_part2() -> Int {
  reader.readFile(year: 2020, day: 8)

  let instructions = reader.nextBlock()!.map { Instruction.parse($0) }
  var visited = Set<Int>()

  return GameConsole(instructions: instructions).run(0, 0, &visited)!
}

func _2020_day8_part1() -> Int {
  reader.readFile(year: 2020, day: 8)

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

func _2020_day7_part2() -> Int {
  reader.readFile(year: 2020, day: 7)

  return countTotalContainingBags(color: "shiny gold", map: buildBagMap(reader: reader))
}

func _2020_day7_part1() -> Int {
  reader.readFile(year: 2020, day: 7)

  var found = Set<String>()
  findHoldingBagsFor(color: "shiny gold", map: buildBagMap(reader: reader), found: &found)

  return found.count
}

func _2020_day6_part2() -> Int {
  reader.readFile(year: 2020, day: 6)

  var count = 0
  while let lines = reader.nextBlock() {
    var map = [Character: Int]()
    lines.forEach { $0.forEach { map[$0, default: 0] += 1 } }
    count += map.keys.reduce(0) { map[$1] == lines.count ? $0 + 1 : $0 }
  }

  return count
}

func _2020_day6_part1() -> Int {
  reader.readFile(year: 2020, day: 6)

  var count = 0
  while let lines = reader.nextBlock() {
    var set = Set<Character>()
    lines.forEach { $0.forEach { set.insert($0) } }
    count += set.count
  }

  return count
}

func _2020_day5_part2() -> Int {
  reader.readFile(year: 2020, day: 5)

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

func _2020_day5_part1() -> Int {
  reader.readFile(year: 2020, day: 5)

  return getSeatIdBounds(reader).high
}

func _2020_day4_part2() -> Int {
  reader.readFile(year: 2020, day: 4)

  var count = 0
  while let lines = reader.nextBlock() {
    let passport = buildPassport(lines: lines)
    count += passport.isValid() ? 1 : 0
  }

  return count
}

func _2020_day4_part1() -> Int {
  reader.readFile(year: 2020, day: 4)

  var count = 0
  while let lines = reader.nextBlock() {
    var requiredFields: Set = ["ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt"]
    lines.forEach {
      $0.components(separatedBy: " ").forEach {
        requiredFields.remove($0.components(separatedBy: ":").first!)
      }
    }

    count += requiredFields.count > 0 ? 0 : 1
  }

  return count
}

func _2020_day3_part2() -> Int {
  reader.readFile(year: 2020, day: 3)

  let coords = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  let grid = buildTobogganGrid(reader: reader)
  let result = coords.reduce(1) { $0 * countTrees(grid: grid, right: $1[0], down: $1[1]) }

  return result
}

func _2020_day3_part1() -> Int {
  reader.readFile(year: 2020, day: 3)

  return countTrees(grid: buildTobogganGrid(reader: reader), right: 3, down: 1)
}

func _2020_day2_part2() -> Int {
  reader.readFile(year: 2020, day: 2)

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

func _2020_day2_part1() -> Int {
  reader.readFile(year: 2020, day: 2)

  var count = 0
  while let line = reader.next() {
    let parts = line.components(separatedBy: " ")
    let range = parts[0].components(separatedBy: "-")

    count +=
      validPassword(
        min: Int(range[0])!,
        max: Int(range[1])!,
        character: parts[1][0],
        password: parts[2]
      ) ? 1 : 0
  }

  return count
}

func _2020_day1_part2() -> Int {
  reader.readFile(year: 2020, day: 1)

  let nums = reader.nextBlock()!.map { Int($0)! }

  return threeSum(nums: nums, target: 2020).reduce(1) { $0 * $1 }
}

func _2020_day1_part1() -> Int {
  reader.readFile(year: 2020, day: 1)

  let nums = reader.nextBlock()!.map { Int($0)! }

  return twoSum(nums: nums, target: 2020).reduce(1) { $0 * nums[$1] }
}

private func validPassword(min: Int, max: Int, character: String, password: String) -> Bool {
  let char = Character(character)
  let count = password.reduce(0) { $1 == char ? $0 + 1 : $0 }

  return count >= min && count <= max
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

private func buildPassport(lines: [String]) -> Passport {
  var passport = Passport()
  lines.forEach {
    $0.components(separatedBy: " ").forEach {
      let parts = $0.components(separatedBy: ":")
      let value = parts[1]
      switch parts[0] {
      case "byr":
        passport.birthYear = Int(value)
      case "iyr":
        passport.issueYear = Int(value)
      case "eyr":
        passport.expirationYear = Int(value)
      case "hgt":
        passport.height = value
      case "hcl":
        passport.hairColor = value
      case "ecl":
        passport.eyeColor = value
      case "pid":
        passport.passportId = value
      case "cid":
        passport.countryId = value
      default:
        break
      }
    }
  }

  return passport
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

private func buildBagMap(reader: Reader) -> [String: Set<Bag>] {
  var map = [String: Set<Bag>]()

  while let line = reader.next() {
    let keyValue = line.components(separatedBy: "contain")
    let keyParts = keyValue[0].components(separatedBy: " ")
    let key = String(keyParts[0] + " " + keyParts[1])
    let bags = keyValue[1].components(separatedBy: ",")

    bags.forEach {
      let bagParts = $0.components(separatedBy: " ")
      let bagNum = Int(bagParts[1])
      if bagNum == nil {
        return
      }

      let bagColor = String(bagParts[2] + " " + bagParts[3])
      map[key, default: Set<Bag>()].insert(Bag(count: bagNum!, color: bagColor))
    }
  }

  return map
}

private func findHoldingBagsFor(color: String, map: [String: Set<Bag>], found: inout Set<String>) {
  map.forEach {
    if $0.value.contains(where: { $0.color == color }) {
      found.insert($0.key)
      findHoldingBagsFor(color: $0.key, map: map, found: &found)
    }
  }
}

private func countTotalContainingBags(color: String, map: [String: Set<Bag>]) -> Int {
  if map[color] == nil {
    return 0
  }

  return map[color]!.reduce(0) { carry, bag in
    let numInnerBags = countTotalContainingBags(color: bag.color, map: map)
    return carry + (bag.count + bag.count * numInnerBags)
  }
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
