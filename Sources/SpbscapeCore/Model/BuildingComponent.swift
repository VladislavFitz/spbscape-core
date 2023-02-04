import Foundation

public struct BuildingComponent<Key: BuildingComponentKey> {
  public let identifier: Identifier?
  public let title: String

  public init(identifier: Identifier?, title: String) {
    self.identifier = identifier
    self.title = title
  }
}

public extension BuildingComponent {
  init(item: ReferencedItem) {
    switch item {
    case let .simple(name):
      self.init(identifier: nil, title: name)
    case let .referenced(name, url):
      let id = Identifier(prefix: Key.urlPrefix, urlString: url.absoluteString)
      self.init(identifier: id, title: name)
    }
  }
}

extension BuildingComponent: CustomStringConvertible {
  public var description: String {
    return title
  }
}

public protocol BuildingComponentKey {
  static var urlPrefix: String { get }
}

public enum ArchitectKey: BuildingComponentKey {
  public static var urlPrefix: String { return "search-architect" }
}

public enum StreetKey: BuildingComponentKey {
  public static var urlPrefix: String { return "search-street" }
}

public enum StyleKey: BuildingComponentKey {
  public static var urlPrefix: String { return "search-archstyle" }
}
