// swift-tools-version:5.3
import PackageDescription


let package = Package(
    name: "UnisseySdk",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "UnisseySdk",
            targets: ["UnisseySdk"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "UnisseySDK",
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySDK-v4.0.0.xcframework.zip",
            checksum: "e631f049efdf253a7ec577cc3b466e0331c4aae251f3c30fe17c82b9b6fb01aa"
        ),
    ]
)

