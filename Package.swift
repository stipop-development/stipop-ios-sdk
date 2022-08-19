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
            url: "https://ios-sdk.stipop.com/0.9.3/Stipop.xcframework.zip",
            checksum: "1b3eeaafe47b22d928372a43a49cc9ee63a00ac0c43ee522b6d794ff3157f0f8"
        )
    ]
)
