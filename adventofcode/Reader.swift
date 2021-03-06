import Foundation

class Reader {
  private let decoder = JSONDecoder()
  private var initialLines = [String]()
  private var lines: IndexingIterator<[String]> = [].makeIterator()
  private let root =
    FileManager.default.homeDirectoryForCurrentUser.path + "/Development/adventofcode/adventofcode"

  func readFile(year: Int, day: Int, sample: Bool = false) {
    let content: String

    do {
      content =
        sample
        ? try String(contentsOfFile: "\(root)/\(year)/resources/samples/day\(day)")
        : try String(contentsOfFile: "\(root)/\(year)/resources/day\(day)")
    } catch {
      fatalError("Could not open file")
    }

    initialLines = content.components(separatedBy: "\n")
    replay()
  }

  func replay() {
    lines = initialLines.makeIterator()
  }

  func next(skipEmpty: Bool = true) -> String? {
    let nextLine = lines.next()
    if skipEmpty && nextLine == "" {
      return next(skipEmpty: skipEmpty)
    }

    return nextLine
  }

  func nextBlock() -> [String]? {
    var result = [String]()

    while let line: String = reader.next(skipEmpty: false) {
      if line == "" {
        return result
      }

      result.append(line)
    }

    return result.isEmpty ? nil : result
  }
}
