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
//            url: "https://storage.googleapis.com/unissey-shared/sdk-ios/UnisseySDK-v2.0.0.xcframework.zip",
//            checksum: "5fbe9bb82c915e85c47756c292d9e4c7ca7b2c4e6d6f531d6dbe13a8b951a218"
//        ),
        
            .binaryTarget(
                name: "UnisseySDK",
                path: "./dist/UnisseySDK.xcframework"
            ),
    ]
)
