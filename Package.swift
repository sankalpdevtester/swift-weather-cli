// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "swift-weather",
    platforms: [
        .macOS(.v12)
    ],
    targets: [
        .executableTarget(
            name: "swift-weather",
            path: "Sources"
        )
    ]
)
