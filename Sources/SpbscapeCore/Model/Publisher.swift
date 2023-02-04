import Foundation

public struct Publisher: Codable {
  public let identifier: Int
  public let label: String

  public init(identifier: Int, label: String) {
    self.identifier = identifier
    self.label = label
  }

  public var cityWallsURL: URL {
    URL(string: "http://www.citywalls.ru/profile/profile.php?uid=\(identifier)")!
  }
}

extension Publisher: CustomStringConvertible {
  public var description: String {
    return label
  }
}
