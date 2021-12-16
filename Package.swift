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
            url: "https://ios-sdk.stipop.com/0.3.0-beta.2/Stipop.xcframework.zip",
            checksum: "b68631f97fdcd549dcebec61b3f903c672fab8b245b8660b2b430d9e0c7b111d"
        )
    ]
)
