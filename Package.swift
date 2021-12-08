// swift-tools-version:5.3
import PackageDescription


let package = Package(
    name: "UnisseySampleApp",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "UnisseySDK",
            targets: ["UnisseySDK"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "UnisseySDK",
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySDK-v1.2.3.xcframework.zip",
            checksum: "62c0c64d0f10898a4888e94e810aa777417589419c42bc790e015752e119bc26"
        ),
    ]
)
