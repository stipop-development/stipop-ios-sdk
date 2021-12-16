// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Stipop",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Stipop",
            targets: ["Stipop"]),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "Stipop",
            url: "https://ios-sdk.stipop.com/0.3.0-beta.3/Stipop.xcframework.zip",
            checksum: "6f2216c30b2406ada6f4fb002dcb5a703be37bb31878fbbe38ac036fd6a17fc5"
        )
    ]
)
