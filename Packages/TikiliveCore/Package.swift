// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "TikiliveCore",

    platforms: [
        .iOS(.v17),
        .tvOS(.v17),
        // not a shipping platform - lets `swift build` / `swift test` run on the host
        .macOS(.v14)
    ],

    products: [
        .library(
            name: "TikiliveCore",
            targets: ["TikiliveCore"]
        ),
    ],

    targets: [
        .target(
            name: "TikiliveCore",
            swiftSettings: [.enableUpcomingFeature("MemberImportVisibility")]
        ),
        .testTarget(
            name: "TikiliveCoreTests",
            dependencies: ["TikiliveCore"]
        ),
    ]
)
