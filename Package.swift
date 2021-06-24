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
            url: "https://www.dropbox.com/s/areqh0ctuqp7q0t/Deepsense-v0.4.0.xcframework.zip?dl=1",
            checksum: "1ef3e4bbbfcd2b6a4a39aec8f5e167106a4dff00edbcdeebde90e1ec92d9bc2e"
        )
    ]
)