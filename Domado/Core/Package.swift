// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [
       
        .library(
            name: "Core",
            type: .dynamic,
            targets: ["Core"]),
    ],
    targets: [
        .target(
            name: "Core",resources: [
                .process("Resources") // 리소스 폴더 추가
            ]),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]
        ),
    ]
)
