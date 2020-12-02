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

extension Bool {
  static func ^ (lhs: Bool, rhs: Bool) -> Bool {
    return lhs != rhs
  }
}

extension Dictionary {
  func getOrDefault(key: Key, defaultValue: Value) -> Value {
    return self[key] == nil ? defaultValue : self[key]!
  }
}
