import Foundation

public enum ReferencedItem {
  case simple(String)
  case referenced(String, URL)

  public init(simple: String) {
    self = .simple(simple)
  }

  public init(title: String, url: URL) {
    self = .referenced(title, url)
  }

  public init<S: StringProtocol>(rawInput: S) {
    let input = String(rawInput)
    guard let urlRange = input.range(of: "<a href=\".*\">", options: .regularExpression) else {
      self = .simple(input)
      return
    }
    let urlString = String(input[urlRange].dropFirst(9).dropLast(2))
    var urlComponents = URLComponents(string: urlString)!
    urlComponents.query = nil
    let url = urlComponents.url!
    var output = input
    output.removeSubrange(urlRange)
    if let closingRange = output.range(of: "</a>") {
      output.removeSubrange(closingRange)
    }
    self = .referenced(output, url)
  }
}

extension ReferencedItem: CustomStringConvertible {
  public var description: String {
    switch self {
    case let .simple(value): return value
    case let .referenced(value, url): return "\(value) (\(url))"
    }
  }
}
