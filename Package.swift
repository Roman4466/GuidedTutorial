// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GuidedTutorial",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "GuidedTutorial",
            targets: ["GuidedTutorial"]),
    ],
    targets: [
        .target(
            name: "GuidedTutorial"),
        .testTarget(
            name: "GuidedTutorialTests",
            dependencies: ["GuidedTutorial"]
        ),
    ]
)
