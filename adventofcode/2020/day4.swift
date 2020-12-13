import XCTest

func _2020_day4_part1(_ reader: Reader) -> Int {
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

func _2020_day4_part2(_ reader: Reader) -> Int {
  var count = 0
  while let lines = reader.nextBlock() {
    let passport = buildPassport(lines: lines)
    count += passport.isValid() ? 1 : 0
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

extension Tests2020 {
  func testDay4Part1() throws {
    reader.readFile(year: 2020, day: 4)
    XCTAssertEqual(237, _2020_day4_part1(reader))
  }
  func testDay4Part2() throws {
    reader.readFile(year: 2020, day: 4)
    XCTAssertEqual(172, _2020_day4_part2(reader))
  }
}
