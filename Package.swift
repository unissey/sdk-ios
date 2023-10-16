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
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySdk-v3.0.0.xcframework.zip",
            checksum: "e1d75a682930a98359e6710ac74624510c234be15b3fbde1e1ecfdc52fc9e5a6"
        ),
    ]
)