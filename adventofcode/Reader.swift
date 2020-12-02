import Foundation

class RE: Error {}

class Reader {
  private let decoder = JSONDecoder()
  private var lines: IndexingIterator<[String]> = [].makeIterator()
  private let root =
    FileManager.default.homeDirectoryForCurrentUser.path + "/Development/adventofcode/adventofcode"

  func readFile(year: Int, day: Int) {
    let content: String

    do {
      content = try String(contentsOfFile: "\(root)/\(year)/resources/day\(day)")
    } catch {
      fatalError("Could not open file")
    }

    lines = content.components(separatedBy: "\n").filter({ !$0.isEmpty }).makeIterator()
  }

  func nextLine() -> String? {
    return lines.next()
  }

  func next<T: Codable>() -> T? {
    guard let line = lines.next() else {
      return nil
    }

    do {
      return try decoder.decode(T.self, from: line.data(using: .utf8)!)
    } catch {
      fatalError("Could not decode")
    }
  }
}
