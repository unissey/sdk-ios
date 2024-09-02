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
            name: "UnisseySdk",
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySdk-v3.1.4.xcframework.zip",
            checksum: "75f3e1a078d9cddfb5b0ea81be274379017d0426d2927fd2f4785b002e4b8243"
        ),
    ]
)
