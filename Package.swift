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
            url: "https://ios-sdk.stipop.com/0.3.0-beta.0/Stipop.xcframework.zip",
            checksum: "a75c9bab0fc9c2246312edfd778b08d17f3cb3806fd76af161f4e973e5e3c191"
        )
    ]
)
