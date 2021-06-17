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
            url: "https://www.dropbox.com/s/wespp1xepvf4qan/Deepsense-v0.3.4.xcframework.zip?dl=1",
            checksum: "a18ccdf39256be799a74eb3fb191c1e1b1c9825309b46e50dd9d7c65e7b5a8fc"
        )
    ]
)