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
            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySDK-v2.0.1.xcframework.zip",
            checksum: "95c4f08ad5e728e47aea499a66bef1c40255ebf1a8689e4298b86d151b93fa6d"
        ),
        
        // [Local distribution]
//        .binaryTarget(
//            name: "UnisseySDK",
//            path: "./dist/UnisseySDK.xcframework"
//        ),
    ]
)
