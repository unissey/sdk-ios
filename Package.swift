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
            name: "Deepsense-v0.3.4",
            url: "https://www.dropbox.com/s/ty19r57lno97k36/Deepsense-v0.3.4.xcframework.zip?dl=1",
            checksum: "3143303c201394889ba5f756d5dce24b825989d414c1c512f341072e629b0891"
        )
    ]
)