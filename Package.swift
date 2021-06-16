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
            url: "https://github.com/thedeepsense/sdk-ios/releases/download/0.3.4/Deepsense-v0.3.4.zip",
            checksum: "3143303c201394889ba5f756d5dce24b825989d414c1c512f341072e629b0891"
        )
    ]
)