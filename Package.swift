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
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySdk-v3.2.0.xcframework.zip",
            checksum: "c8fd49e170ab25304f61b55c860eb9027d36b012dd87b540c87dc3651d885466"
        ),
    ]
)
