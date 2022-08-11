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
            url: "https://ios-sdk.stipop.com/0.9.2/Stipop.xcframework.zip",
            checksum: "310b6aca34f4589ea75e3ab7e215ab2e4cd3e5f98c0e6475553d22287a73e48e"
        )
    ]
)
