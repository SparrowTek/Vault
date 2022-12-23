// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Vault",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
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
