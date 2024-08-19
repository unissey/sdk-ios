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
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySdk-v3.1.1.xcframework.zip",
            checksum: "0ea1571ea566123d2d8814f8c916874794921f2323ce50d6494d939986ca680d"
        ),
    ]
)
