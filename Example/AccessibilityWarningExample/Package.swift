// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AccessibilityWarningExample",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .executable(
            name: "AccessibilityWarningExample",
            targets: ["AccessibilityWarningExample"])
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        .executableTarget(
            name: "AccessibilityWarningExample",
            dependencies: [
                .product(name: "GuidedTutorial", package: "GuidedTutorial")
            ],
            path: "Sources"
        )
    ]
)
