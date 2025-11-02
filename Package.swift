// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PodiumRequestsClient",
    platforms: [
      .iOS(.v17),
      .macOS(.v14),
      .visionOS(.v1)
    ],
    products: [
        .library(
            name: "PodiumRequestsClient",
            targets: ["PodiumRequestsClient"]
        ),
    ],
    dependencies: [
      .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.2")
    ],
    targets: [
        .target(
            name: "PodiumRequestsClient",
            dependencies: [
              .product(name: "Alamofire", package: "Alamofire")
            ]
        ),
        .testTarget(
          name: "PodiumRequestsClientTests",
          dependencies: [
            "PodiumRequestsClient"
          ]
        )
    ]
)
