import Foundation

public struct Address: Codable {
  public let streetID: Int
  public let streetName: String
  public let streetBuildingIdentifier: String
}

extension Address: CustomStringConvertible {
  public var description: String {
    return "\(streetName), \(streetBuildingIdentifier)"
  }
}

public extension Array where Element == Address {
  init(buildingID: Int, components: [Building.Component], streetRegistry: [String: Int]) {
    func parseAddress(from rawAddress: String, streetID: Int?) -> Address? {
      let addressComponents = rawAddress.split(separator: ",")
      guard addressComponents.count == 2 else { return nil }
      let streetName = String(addressComponents.first!).trimmingCharacters(in: .whitespacesAndNewlines)
      let streetBuildingIdentifier = String(addressComponents.last!).trimmingCharacters(in: .whitespacesAndNewlines)
      let effectiveStreetID: Int
      if let providedStreetID = streetID {
        effectiveStreetID = providedStreetID
      } else if let registryStreetID = streetRegistry[streetName] {
        effectiveStreetID = registryStreetID
      } else {
        print("\(buildingID):  No street found with name: \(streetName)")
        return nil
      }
      return .init(streetID: effectiveStreetID,
                   streetName: streetName,
                   streetBuildingIdentifier: streetBuildingIdentifier)
    }

    var output = [Address]()
    for component in components {
      let subcomponents = component.title.components(separatedBy: "\n<br>")
      subcomponents
        .first
        .flatMap { parseAddress(from: $0, streetID: component.id) }
        .flatMap { output.append($0) }
      subcomponents
        .dropFirst()
        .compactMap { parseAddress(from: $0, streetID: nil) }
        .forEach { output.append($0) }
    }
    self = output
  }
}
