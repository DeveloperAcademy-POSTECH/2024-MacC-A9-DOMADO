// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rent",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
               ],
    
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Rent",
            type: .dynamic,
            targets: ["Rent"]),
    ],
    
    dependencies: [
        .package(path: "../Core"),
        // CodeScanner 의존성 추가
        .package(url: "https://github.com/twostraws/CodeScanner", from: "2.3.3")

    ],
    
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Rent",
            dependencies: ["Core",
                           // Rent 타겟에 CodeScanner 의존성 추가
                           .product(name: "CodeScanner", package: "CodeScanner")
                          ]
        ),
        .testTarget(
            name: "RentTests",
            dependencies: ["Rent"]
        ),
    ]
)
