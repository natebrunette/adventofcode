enum Direction: RawRepresentable {
  case right, left, up, down
  case east, west, north, south
  case upRight, upLeft, downRight, downLeft
  case northEast, northWest, southEast, southWest

  var rawValue: RawValue {
    switch self {
    case .right: return (0, 1)
    case .left: return (0, -1)
    case .up: return (-1, 0)
    case .down: return (1, 0)
    case .east: return (0, 1)
    case .west: return (0, -1)
    case .north: return (-1, 0)
    case .south: return (1, 0)
    case .upRight: return (-1, 1)
    case .upLeft: return (-1, -1)
    case .downRight: return (1, 1)
    case .downLeft: return (1, -1)
    case .northEast: return (-1, 1)
    case .northWest: return (-1, -1)
    case .southEast: return (1, 1)
    case .southWest: return (1, -1)
    }
  }

  var row: Int { self.rawValue.0 }
  var col: Int { self.rawValue.1 }
  var x: Int { self.rawValue.1 }
  var y: Int { self.rawValue.0 }

  static var directions: [Direction] { [.right, .left, .up, .down] }
  static var diagonals: [Direction] { [.upRight, .upLeft, .downRight, .downLeft] }

  init?(rawValue: (Int, Int)) {
    switch rawValue {
    case (0, 1): self = .right
    case (0, -1): self = .left
    case (-1, 0): self = .up
    case (1, 0): self = .down
    case (-1, 1): self = .upRight
    case (-1, -1): self = .upLeft
    case (1, 1): self = .downRight
    case (1, -1): self = .downLeft
    default: return nil
    }
  }
}
