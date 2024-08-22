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
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySdk-v3.1.3.xcframework.zip",
            checksum: "e7a9af1e6c119ac60a082521febe060545d98f8355ab12e0be460ced353f8407"
        ),
    ]
)
