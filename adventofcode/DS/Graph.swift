struct Graph<T: Equatable & Hashable> {
  class Node: Hashable {
    let row: Int
    let col: Int
    var value: T

    init(_ row: Int, _ col: Int, _ value: T) {
      self.row = row
      self.col = col
      self.value = value
    }

    func value(_ value: T) -> Graph<T>.Node {
      Node(row, col, value)
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
      lhs.row == rhs.row
        && lhs.col == rhs.col
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(row)
      hasher.combine(col)
    }
  }

  private var adjList = [Node: Set<Node>]()

  mutating func add(_ value: Node, to: Node) {
    adjList[to, default: Set<Node>()].insert(value)
  }

  func get(_ node: Node) -> Set<Node> {
    adjList[node, default: Set<Node>()]
  }

  func nodes() -> [Node] {
    [Node](adjList.keys)
  }

  func findNodes(where predicate: (Node) -> Bool) -> [Node] {
    [Node](adjList.keys.filter(predicate))
  }
}
