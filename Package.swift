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
            checksum: "208f18bfb9b96a5e6b35240283c7e7879462aa7fb6f097554dde7eb4a0bb5a81"
        )
    ]
)
