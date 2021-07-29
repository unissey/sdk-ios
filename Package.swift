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
            url: "https://storage.googleapis.com/deepsense-shared/sdk-ios/Deepsense-v1.0.2.xcframework.zip",
            checksum: "34d9d4d059a646fa2ed7b882b360b7123858aa1e7135b705d725a949554eeec4"
        )
    ]
)
