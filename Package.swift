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
//  This doesn't work : we get an error : 'downloaded archive of binary target does not contain expected binary artifact'
//        .binaryTarget(
//            name: "UnisseySDK",
//            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySDK-v1.2.xcframework.zip",
//            checksum: "f1dc30cbb1be75cddf5596a6ab43447f8810197c716495d283ae1afd3928d18b"
//        ),
        
            .binaryTarget(
                name: "UnisseySDK",
                path: "./dist/UnisseySDK.xcframework"
            ),
    ]
)
