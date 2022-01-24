// swift-tools-version:5.3
import PackageDescription


let package = Package(
    name: "UnisseySDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "UnisseySDK",
            targets: ["UnisseySDK"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "UnisseySDK",
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySDK-v1.2.6.xcframework.zip",
            checksum: "1282990071b3fe0d65b7f6d3e32ec12ba50cbd1b1bf0bd606c5ec15a19aeafc7"
        ),
    ]
)
