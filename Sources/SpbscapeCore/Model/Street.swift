import Foundation

public struct Street: Codable {
  public let id: Int
  public let title: String
  public let cityID: Int
  public let buildingsCount: Int

  public init(id: Int, title: String, cityID: Int, buildingsCount: Int) {
    self.id = id
    self.title = title
    self.cityID = cityID
    self.buildingsCount = buildingsCount
  }
}
