import Foundation

public struct Identifier {
  public let id: Int

  public init?(prefix: String, urlString: String) {
    let suffix = ".html"
    guard let range = urlString.range(of: "\(prefix)[0-9]+\(suffix)", options: .regularExpression) else {
      return nil
    }
    let idString = urlString[range].dropFirst(prefix.count).dropLast(suffix.count)
    guard let id = Int(idString) else {
      return nil
    }
    self.id = id
  }
}
