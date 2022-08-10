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
            url: "https://ios-sdk.stipop.com/0.9.1-beta.1/Stipop.xcframework.zip",
            checksum: "7ee10ace7ee439d15f65c0fa0d2c102b75b2bc15c5eb8064026f12c98b9b239f"
        )
    ]
)
