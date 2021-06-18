// swift-tools-version:5.3
import PackageDescription


let package = Package(
    name: "Deepsense",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Deepsense",
            targets: ["Deepsense"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "Deepsense",
            url: "https://github.com/thedeepsense/sdk-ios/releases/download/v0.3.4/Deepsense-v0.3.4.xcframework.zip",
            checksum: "5e703c416ec0874a174d269ffca84fef3a77b5e807b69da6b89af5db9a2dfc0c"
        )
    ]
)