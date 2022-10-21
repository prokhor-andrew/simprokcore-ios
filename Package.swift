// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "simprokcore",
    products: [
        .library(
            name: "simprokcore",
            targets: ["simprokcore"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/simprok-dev/simprokmachine-ios.git",
            exact: .init(1, 1, 8)
        ),
        .package(
            url: "https://github.com/simprok-dev/simprokcontroller-ios.git",
            exact: .init(1, 0, 1)
        ),
    ],
    targets: [
        .target(
            name: "simprokcore",
            dependencies: [
                .product(
                    name: "simprokmachine",
                    package: "simprokmachine-ios"
                ),
                .product(
                    name: "simprokcontroller",
                    package: "simprokcontroller-ios"
                )
            ]
        )
    ]
)
