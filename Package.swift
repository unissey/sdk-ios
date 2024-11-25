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
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySdk-v3.4.0.xcframework.zip",
            checksum: "55a7042f234888344b9a048968bd491442f653b20054b0515074369e6f2381be"
        ),
    ]
)
