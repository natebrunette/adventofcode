extension Int {
  @discardableResult
  static prefix func ++ (x: inout Int) -> Int {
    x += 1
    return x
  }

  @discardableResult
  static postfix func ++ (x: inout Int) -> Int {
    defer { x += 1 }
    return x
  }

  @discardableResult
  static prefix func -- (x: inout Int) -> Int {
    x -= 1
    return x
  }

  @discardableResult
  static postfix func -- (x: inout Int) -> Int {
    defer { x -= 1 }
    return x
  }
}

extension StringProtocol {
  subscript(offset: Int) -> Character {
    self[index(startIndex, offsetBy: offset)]
  }
}

extension Bool {
  static func ^ (lhs: Bool, rhs: Bool) -> Bool {
    return lhs != rhs
  }
}
