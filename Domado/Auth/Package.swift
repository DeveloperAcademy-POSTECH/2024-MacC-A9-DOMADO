// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Auth",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [

        .library(
            name: "Auth",
            type: .dynamic,
            targets: ["Auth"]),
    ],
    dependencies: [
        .package(path: "../Core")
    ],
    targets: [

        .target(
            name: "Auth",
            dependencies: ["Core"]
        ),
        .testTarget(
            name: "AuthTests",
            dependencies: ["Auth"]
        ),
    ]
)
