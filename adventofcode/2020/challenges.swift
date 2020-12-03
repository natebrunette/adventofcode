let reader = Reader()

func _2020_day3_part2() {
  reader.readFile(year: 2020, day: 3)

  let coords = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  let grid = buildTobogganGrid(reader: reader)
  var result = 1

  for coord in coords {
    result *= countTrees(grid: grid, right: coord[0], down: coord[1])
  }

  print(result)
}

func _2020_day3_part1() {
  reader.readFile(year: 2020, day: 3)

  print(countTrees(grid: buildTobogganGrid(reader: reader), right: 3, down: 1))
}

func _2020_day2_part2() {
  reader.readFile(year: 2020, day: 2)

  var count = 0
  while let line: String = reader.nextLine() {
    let parts = line.components(separatedBy: " ")
    let range = parts[0].components(separatedBy: "-")
    let pos1 = Int(range[0])! - 1
    let pos2 = Int(range[1])! - 1
    let character = parts[1][0]
    let password = parts[2]
    let isValid = (password[pos1] == character) ^ (password[pos2] == character)

    count += isValid ? 1 : 0
  }

  print(count)
}

func _2020_day2_part1() {
  reader.readFile(year: 2020, day: 2)

  var count = 0
  while let line: String = reader.nextLine() {
    let parts = line.components(separatedBy: " ")
    let range = parts[0].components(separatedBy: "-")
    let min = Int(range[0])!
    let max = Int(range[1])!
    let character = parts[1][0]
    let password = parts[2]

    count +=
      validPassword(min: min, max: max, character: character, password: password) ? 1 : 0
  }

  print(count)
}

func _2020_day1_part2() {
  reader.readFile(year: 2020, day: 1)
  let nums: [Int] = reader.next()!
  let target: Int = reader.next()!
  print(threeSum(nums: nums, target: target))
}

func _2020_day1_part1() {
  reader.readFile(year: 2020, day: 1)
  let nums: [Int] = reader.next()!
  let target: Int = reader.next()!
  print(twoSum(nums: nums, target: target))
}

private func validPassword(min: Int, max: Int, character: Character, password: String) -> Bool {
  let count = Array(password).reduce(0) { carry, char in
    char == character ? carry + 1 : carry
  }

  return count >= min && count <= max
}

private func buildTobogganGrid(reader: Reader) -> [[String.Element]] {
  var grid = [[Character]]()
  var x = 0
  var y = 0

  while let line: String = reader.nextLine() {
    y = 0
    grid.append([Character](repeating: Character("."), count: line.count))

    for char in line {
      grid[x][y++] = char
    }

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
