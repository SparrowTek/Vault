// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Vault",
    products: [
        .library(
            name: "Vault",
            targets: ["Vault"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Vault",
            dependencies: []),
    ]
)
