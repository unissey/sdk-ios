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
            targets: ["UnisseySdk", "UnisseyHeadlessSdk"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "UnisseyHeadlessSdk",
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/headless/UnisseyHeadlessSdk-v1.0.0.xcframework.zip",
            checksum: "a6e66ba99cf6cbe520a98429662857740bfd829e7e54b30e7aaf9ba7b4d4bd94"
        ),
        .binaryTarget(
            name: "UnisseySdk",
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/ui/UnisseySdk-v5.0.0.xcframework.zip",
            checksum: "cd4d2af2a1eb6aa3a4b5c7384e7c31484b05d84490d4cd7312c907cf508d7bfd"
        ),
    ]
)
