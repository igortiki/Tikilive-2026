// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "TikiliveUI",

    // UIKit-based: iOS and tvOS only, no macOS host build
    platforms: [
        .iOS(.v17),
        .tvOS(.v17)
    ],

    products: [
        .library(
            name: "TikiliveUI",
            targets: ["TikiliveUI"]
        ),
    ],

    targets: [
        .target(
            name: "TikiliveUI",
            swiftSettings: [.enableUpcomingFeature("MemberImportVisibility")]
        ),
        .testTarget(
            name: "TikiliveUITests",
            dependencies: ["TikiliveUI"]
        ),
    ]
)
