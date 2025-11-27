// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SimpleExample",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .executable(
            name: "SimpleExample",
            targets: ["SimpleExample"])
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        .executableTarget(
            name: "SimpleExample",
            dependencies: [
                .product(name: "GuidedTutorial", package: "GuidedTutorial")
            ],
            path: "Sources"
        )
    ]
)
