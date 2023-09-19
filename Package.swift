// swift-tools-version:5.3
import PackageDescription


let package = Package(
    name: "UnisseySDK",
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
            name: "UnisseySdk",
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySdk-v4.0.0.xcframework.zip",
            checksum: "c8c3b2d1dcacd1f7c8d55e9efe2e5e33cd5a7f1788f23496293126ce81f0ccfd"
        ),
        
        // [Local distribution]
//        .binaryTarget(
//            name: "UnisseySDK",
//            path: "./dist/UnisseySDKLocal.xcframework"
//        ),
    ]
)
