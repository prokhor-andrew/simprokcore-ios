// swift-tools-version:5.5
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
            name: "simprokmachine",
            url: "https://github.com/simprok-dev/simprokmachine-ios.git",
            .exactItem(.init(1, 1, 2))
        )
    ],
    targets: [
        .target(
            name: "simprokcore",
            dependencies: [
                .product(
                    name: "simprokmachine",
                    package: "simprokmachine"
                )
            ]
        )
    ]
)
