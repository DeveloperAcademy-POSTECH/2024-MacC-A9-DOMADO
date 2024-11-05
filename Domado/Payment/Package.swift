// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Payment",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Payment",
            type: .dynamic,
            targets: ["Payment"]),
    ],
    dependencies: [
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "Payment",
            dependencies: ["Core"]
        ),
        .testTarget(
            name: "PaymentTests",
            dependencies: ["Payment"]
        ),
    ]
)
