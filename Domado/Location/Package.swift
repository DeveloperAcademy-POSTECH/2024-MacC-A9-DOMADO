// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Location",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Location",
            type: .dynamic, // 패키지는 패키지대로 빌드가 되어서 올라가고, 메인 모듈은 모듈대로 각자 빌드된 다음에, 메모리 단계에서 묶이는 것
            targets: ["Location"]),
    ],
    dependencies: [
        .package(path: "../Core")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Location",
            dependencies: ["Core"], // 나중에는 의존이 생긴 모듈을 추가로 표시
            resources: [
                    .process("Resources") // 에셋을 사용하기 위한 리소스 선언 추가
                ]
            
        ),
        .testTarget(
            name: "LocationTests",
            dependencies: ["Location"]
        ),
    ]
)
