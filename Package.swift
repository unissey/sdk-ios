// swift-tools-version:5.3
import PackageDescription


let package = Package(
    name: "unissey-sdk",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "unissey-sdk",
            targets: ["unissey-sdk"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "unissey-sdk",
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/Unissey-v1.2.0.xcframework.zip",
            checksum: "8e021f591c9dbf6f32b5a9c30f1bb7b7b599487a4a5da990a74b1a36fdd8c9a7"
        )
    ]
)
