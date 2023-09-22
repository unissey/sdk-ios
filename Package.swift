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
            checksum: "08db4805da529a83181f562cc4b12dc1ee93760b6f20f33dd18e9ac7d3a19495"
        ),
        
        // [Local distribution]
//        .binaryTarget(
//            name: "UnisseySDK",
//            path: "./dist/UnisseySDKLocal.xcframework"
//        ),
    ]
)
