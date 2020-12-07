struct Bag: Hashable {
  var count: Int
  var color: String

  init(count: Int, color: String) {
    self.count = count
    self.color = color
  }
}
