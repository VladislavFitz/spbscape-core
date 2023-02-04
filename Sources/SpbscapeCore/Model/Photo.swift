import Foundation

public struct Photo: Codable {
  public let url: URL
  public let title: String?
  public var publisher: Publisher?

  public init(url: URL, title: String?, publisher: Publisher?) {
    self.url = url
    self.title = title
    self.publisher = publisher
  }
}

extension Photo: CustomStringConvertible {
  public var description: String {
    return "\(title ?? "no title") by \(publisher?.description ?? "no publisher")"
  }
}
