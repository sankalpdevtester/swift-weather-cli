// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftWeatherCLI",
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.13.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.2"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.2"),
    ],
    targets: [
        .executableTarget(name: "SwiftWeatherCLI", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            .product(name: "Logging", package: "swift-log"),
        ]),
    ]
)