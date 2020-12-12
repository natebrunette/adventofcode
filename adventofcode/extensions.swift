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
  func toArray() -> [String] {
    self.map { String($0) }
  }
}

extension String {

  /**
   Enables passing in negative indices to access characters
   starting from the end and going backwards.
   if num is negative, then it is added to the
   length of the string to retrieve the true index.
   */
  public func negativeIndex(_ num: Int) -> Int {
    num < 0 ? num + self.count : num
  }

  public func strOpenRange(index i: Int) -> Range<String.Index> {
    let j = negativeIndex(i)
    return strOpenRange(j..<(j + 1), checkNegative: false)
  }

  public func strOpenRange(_ range: Range<Int>, checkNegative: Bool = true) -> Range<String.Index> {

    var lower = range.lowerBound
    var upper = range.upperBound

    if checkNegative {
      lower = negativeIndex(lower)
      upper = negativeIndex(upper)
    }

    let idx1 = index(self.startIndex, offsetBy: lower)
    let idx2 = index(self.startIndex, offsetBy: upper)

    return idx1..<idx2
  }

  public func strClosedRange(
    _ range: CountableClosedRange<Int>,
    checkNegative: Bool = true
  ) -> ClosedRange<String.Index> {

    var lower = range.lowerBound
    var upper = range.upperBound

    if checkNegative {
      lower = negativeIndex(lower)
      upper = negativeIndex(upper)
    }

    let start = self.index(self.startIndex, offsetBy: lower)
    let end = self.index(start, offsetBy: upper - lower)

    return start...end
  }

  // MARK: - Subscripts

  /**
   Gets and sets a character at a given index.
   Negative indices are added to the length so that
   characters can be accessed from the end backwards

   Usage: `string[n]`
   */
  public subscript(_ i: Int) -> String {
    get {
      String(self[strOpenRange(index: i)])
    }
    set {
      let range = strOpenRange(index: i)
      replaceSubrange(range, with: newValue)
    }
  }

  /**
   Gets and sets characters in an open range.
   Supports negative indexing.

   Usage: `string[n..<n]`
   */
  public subscript(_ r: Range<Int>) -> String {
    get {
      String(self[strOpenRange(r)])
    }
    set {
      replaceSubrange(strOpenRange(r), with: newValue)
    }
  }

  /**
   Gets and sets characters in a closed range.
   Supports negative indexing

   Usage: `string[n...n]`
   */
  public subscript(_ r: CountableClosedRange<Int>) -> String {
    get {
      String(self[strClosedRange(r)])
    }
    set {
      replaceSubrange(strClosedRange(r), with: newValue)
    }
  }

  /// `string[n...]`. See PartialRangeFrom
  public subscript(r: PartialRangeFrom<Int>) -> String {
    get {
      String(self[strOpenRange(r.lowerBound..<self.count)])
    }
    set {
      replaceSubrange(strOpenRange(r.lowerBound..<self.count), with: newValue)
    }
  }

  /// `string[...n]`. See PartialRangeThrough
  public subscript(r: PartialRangeThrough<Int>) -> String {
    get {
      let upper = negativeIndex(r.upperBound)
      return String(self[strClosedRange(0...upper, checkNegative: false)])
    }
    set {
      let upper = negativeIndex(r.upperBound)
      replaceSubrange(
        strClosedRange(0...upper, checkNegative: false), with: newValue
      )
    }
  }

  /// `string[...<n]`. See PartialRangeUpTo
  public subscript(r: PartialRangeUpTo<Int>) -> String {
    get {
      let upper = negativeIndex(r.upperBound)
      return String(self[strOpenRange(0..<upper, checkNegative: false)])
    }
    set {
      let upper = negativeIndex(r.upperBound)
      replaceSubrange(
        strOpenRange(0..<upper, checkNegative: false), with: newValue
      )
    }
  }

}

extension Bool {
  static func ^ (lhs: Bool, rhs: Bool) -> Bool {
    lhs != rhs
  }
}

extension Array where Element == String {
  func asInt() -> [Int] {
    self.map { Int($0)! }
  }
}
