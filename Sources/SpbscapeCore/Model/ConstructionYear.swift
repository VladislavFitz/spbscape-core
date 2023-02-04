import Foundation

public enum ConstructionYear: Equatable {
  case single(Int)
  case interval(Int, Int)
}

extension ConstructionYear: Codable {
  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    let firstYear = try container.decode(Int.self)
    let secondYear = try container.decodeIfPresent(Int.self)
    if let secondYear = secondYear {
      self = .interval(firstYear, secondYear)
    } else {
      self = .single(firstYear)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    switch self {
    case let .single(year):
      try container.encode(year)
    case let .interval(start, end):
      try container.encode(start)
      try container.encode(end)
    }
  }
}

extension ConstructionYear: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .single(year):
      return String(year)
    case let .interval(start, end):
      return "\(String(start)) - \(String(end))"
    }
  }
}

public extension Array where Element == ConstructionYear {
  init(item: ReferencedItem) {
    var years: [ConstructionYear] = []
    if case let .simple(value) = item {
      for interval in value.split(separator: ",") {
        let cleansedInterval = interval.trimmingCharacters(in: .init(charactersIn: " "))
        let components = cleansedInterval.split(separator: "-").map(String.init).compactMap(Int.init)
        switch components.count {
        case 2:
          years.append(.interval(components.first!, components.last!))
        case 1:
          years.append(.single(components.first!))
        default:
          continue
        }
      }
    }
    self = years
  }
}
