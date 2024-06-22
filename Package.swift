// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "ide-icons",
    platforms: [
        .macOS(.v11),
        .macCatalyst(.v14),
        .iOS(.v14),
        .watchOS(.v7),
        .tvOS(.v14),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "IDEIcons", targets: ["IDEIcons"]),
    ],
    targets: [
        .target(name: "IDEIcons"),
    ]
)
