import Foundation

class RE: Error {}

class Reader {
  let decoder = JSONDecoder()
  var lines: IndexingIterator<[String]> = [].makeIterator()
  let root =
    FileManager.default.homeDirectoryForCurrentUser.path + "/Development/adventofcode/adventofcode"

  func readFile(year: Int, day: Int, part: Int = 1) {
    let content: String

    do {
      content = try String(contentsOfFile: "\(root)/\(year)/resources/day\(day)_part\(part)")
    } catch {
      fatalError("Could not open file")
    }

    lines = content.components(separatedBy: "\n").filter({ !$0.isEmpty }).makeIterator()
  }

  func nextLine<T: Codable>() -> T {
    guard let line = lines.next() else {
      fatalError("Could not read next line")
    }

    do {
      return try decoder.decode(T.self, from: line.data(using: .utf8)!)
    } catch {
      fatalError("Could not decode")
    }
  }
}
