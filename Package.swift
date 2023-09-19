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
            name: "UnisseySDK",
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySDK-v2.0.0.xcframework.zip",
            checksum: "bae72d808b8dadc418aabcdd554ae42c65ac63fe72d3b42f969c5b4e29e7fc76"
        ),
        
        // [Local distribution]
//        .binaryTarget(
//            name: "UnisseySDK",
//            path: "./dist/UnisseySDKLocal.xcframework"
//        ),
    ]
)
