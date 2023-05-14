// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "simprokcore",
    products: [
        .library(
            name: "simprokcore",
            targets: ["simprokcore"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/simprok-dev/simprokstate-ios.git",
            exact: .init(1, 2, 29)
        )
    ],
    targets: [
        .target(
            name: "simprokcore",
            dependencies: [
                .product(
                    name: "simprokstate",
                    package: "simprokstate-ios"
                )
            ]
        )
    ]
)
