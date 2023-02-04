import CoreLocation
import Foundation
import Geohash

public struct Geohashes: Codable {
  let hash5: String
  let hash6: String
  let hash7: String
  let hash8: String
  let hash9: String

  init(location: CLLocationCoordinate2D) {
    hash5 = Geohash.encode(latitude: location.latitude, longitude: location.longitude, length: 5)
    hash6 = Geohash.encode(latitude: location.latitude, longitude: location.longitude, length: 6)
    hash7 = Geohash.encode(latitude: location.latitude, longitude: location.longitude, length: 7)
    hash8 = Geohash.encode(latitude: location.latitude, longitude: location.longitude, length: 8)
    hash9 = Geohash.encode(latitude: location.latitude, longitude: location.longitude, length: 9)
  }
}
