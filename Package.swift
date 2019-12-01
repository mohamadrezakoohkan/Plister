// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Plister",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v8),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "Plister",
            targets: ["Plister"]),
    ],
    targets: [
        .target(
            name: "Plister",
            path: "Source"
        ),
        .testTarget(
            name: "PlisterTests",
            dependencies: [
                "Plister"
            ],
            path: "PlisterTests"
        )
    ],
    swiftLanguageVersions: [
        .v4_2
    ]
)
