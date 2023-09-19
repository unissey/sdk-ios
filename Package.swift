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
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySDK-v4.0.0.xcframework.zip",
            checksum: "e631f049efdf253a7ec577cc3b466e0331c4aae251f3c30fe17c82b9b6fb01aa"
        ),
        
        // [Local distribution]
//        .binaryTarget(
//            name: "UnisseySDK",
//            path: "./dist/UnisseySDKLocal.xcframework"
//        ),
    ]
)
