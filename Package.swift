// swift-tools-version:5.3
import PackageDescription


let package = Package(
    name: "Deepsense",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Deepsense",
            targets: ["Deepsense"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "Deepsense",
            url: "https://github.com/thedeepsense/sdk-ios/releases/download/0.3.3/Deepsense-v0.3.3.zip",
            checksum: ""
        )
    ]
)