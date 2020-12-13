import XCTest

func _2020_day7_part1(_ reader: Reader) -> Int {
  var found = Set<String>()
  findHoldingBagsFor(color: "shiny gold", map: buildBagMap(reader: reader), found: &found)

  return found.count
}

func _2020_day7_part2(_ reader: Reader) -> Int {
  countTotalContainingBags(color: "shiny gold", map: buildBagMap(reader: reader))
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

extension Tests2020 {
  func testDay7Part1() throws {
    reader.readFile(year: 2020, day: 7)
    XCTAssertEqual(302, _2020_day7_part1(reader))
  }
  func testDay7Part2() throws {
    reader.readFile(year: 2020, day: 7)
    XCTAssertEqual(4165, _2020_day7_part2(reader))
  }
}
