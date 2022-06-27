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
            url: "https://ios-sdk.stipop.com/0.7.0-beta.2/Stipop.xcframework.zip",
            checksum: "d6a660aef3d48d990cd22bc4f1a65df5a88f6b918cd86ff4ae582c48d3fd2072"
        )
    ]
)
