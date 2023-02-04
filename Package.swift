// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SpbscapeCore",
  products: [
    .library(
      name: "SpbscapeCore",
      targets: ["SpbscapeCore"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/nh7a/Geohash",
             from: "1.0.0")
  ],
  targets: [
    .target(
      name: "SpbscapeCore",
      dependencies: ["Geohash"]
    ),
    .testTarget(
      name: "SpbscapeCoreTests",
      dependencies: ["SpbscapeCore"]
    )
  ]
)
