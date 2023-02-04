import CoreLocation
import Foundation

public struct Building {
  public let id: Int
  public let titles: [String]
  public let location: CLLocationCoordinate2D
  public let geohashes: Geohashes
  public let architects: [Component]
  public let styles: [Component]
  public let addresses: [Address]
  public let constructionYears: [ConstructionYear]
  public let photos: [Photo]

  public struct Component: Codable {
    public let id: Int
    public let title: String
  }

  public init(id: Int,
              titles: [String],
              location: CLLocationCoordinate2D,
              architects: [Component],
              styles: [Component],
              addresses: [Address],
              constructionYears: [ConstructionYear],
              photos: [Photo]) {
    self.id = id
    self.titles = titles
    self.location = location
    geohashes = .init(location: location)
    self.architects = architects
    self.styles = styles
    self.addresses = addresses
    self.constructionYears = constructionYears
    self.photos = photos
  }
}

extension Building: Codable {
  struct AlgoliaGeolocation: Codable {
    let lat: Double
    let lng: Double

    var coordinate: CLLocationCoordinate2D {
      return .init(latitude: lat, longitude: lng)
    }

    init(coordinate: CLLocationCoordinate2D) {
      lat = coordinate.latitude
      lng = coordinate.longitude
    }
  }

  enum CodingKeys: String, CodingKey {
    case id = "objectID"
    case titles
    case location = "_geoloc"
    case geohashes
    case architects
    case styles
    case addresses
    case constructionYears
    case photos
    case goodAddresses
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = Int(try container.decode(String.self, forKey: .id))!
    titles = try container.decode([String].self, forKey: .titles)
    location = (try container.decode(AlgoliaGeolocation.self, forKey: .location)).coordinate
    geohashes = try container.decode(Geohashes.self, forKey: .geohashes)
    architects = try container.decode([Component].self, forKey: .architects)
    styles = try container.decode([Component].self, forKey: .styles)
    addresses = try container.decode([Address].self, forKey: .addresses)
    constructionYears = try container.decode([ConstructionYear].self, forKey: .constructionYears)
    photos = try container.decode([Photo].self, forKey: .photos)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(String(id), forKey: .id)
    try container.encode(titles, forKey: .titles)
    try container.encode(AlgoliaGeolocation(coordinate: location), forKey: .location)
    try container.encode(geohashes, forKey: .geohashes)
    try container.encode(architects, forKey: .architects)
    try container.encode(styles, forKey: .styles)
    try container.encode(addresses, forKey: .addresses)
    try container.encode(constructionYears, forKey: .constructionYears)
    try container.encode(photos, forKey: .photos)
  }
}

public extension Building.Component {
  init?<T>(_ buildingComponent: BuildingComponent<T>) {
    guard let id = buildingComponent.identifier else { return nil }
    self.id = id.id
    title = buildingComponent.title
  }
}
