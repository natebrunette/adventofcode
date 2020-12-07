import XCTest

@testable import adventofcode

class Tests2020: XCTestCase {
  func testDay7Part2() throws {
    XCTAssertEqual(4165, _2020_day7_part2())
  }
  func testDay7Part1() throws {
    XCTAssertEqual(302, _2020_day7_part1())
  }
  func testDay6Part2() throws {
    XCTAssertEqual(3351, _2020_day6_part2())
  }
  func testDay6Part1() throws {
    XCTAssertEqual(6504, _2020_day6_part1())
  }
  func testDay5Part2() throws {
    XCTAssertEqual(519, _2020_day5_part2())
  }
  func testDay5Part1() throws {
    XCTAssertEqual(906, _2020_day5_part1())
  }
  func testDay4Part2() throws {
    XCTAssertEqual(172, _2020_day4_part2())
  }
  func testDay4Part1() throws {
    XCTAssertEqual(237, _2020_day4_part1())
  }
  func testDay3Part2() throws {
    XCTAssertEqual(3_898_725_600, _2020_day3_part2())
  }
  func testDay3Part1() throws {
    XCTAssertEqual(272, _2020_day3_part1())
  }
  func testDay2Part2() throws {
    XCTAssertEqual(472, _2020_day2_part2())
  }
  func testDay2Part1() throws {
    XCTAssertEqual(640, _2020_day2_part1())
  }
  func testDay1Part2() throws {
    XCTAssertEqual(278_783_190, _2020_day1_part2())
  }
  func testDay1Part1() throws {
    XCTAssertEqual(538_464, _2020_day1_part1())
  }
}