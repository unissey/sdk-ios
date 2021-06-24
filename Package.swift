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
            url: "https://www.dropbox.com/s/5ob1jf1x98ho357/Deepsense-v0.4.1.xcframework.zip?dl=1",
            checksum: "db6d373e8ad8440b318e6d7ba595e09da56e10d50459f3558963e968df5adf5d"
        )
    ]
)