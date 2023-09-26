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
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySdk-v4.0.0.xcframework.zip",
            checksum: "fcc11396c90144847c55ba4aaad583ecfefcf6d48525f076b902aeef96aaffa3"
        ),
    ]
)