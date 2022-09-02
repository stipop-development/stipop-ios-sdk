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
            url: "https://ios-sdk.stipop.com/0.9.6/Stipop.xcframework.zip",
            checksum: "63a1226c4f7d553dae73a13d79e478f9ac0ed8620dbf300ec1bb36f5a3761989"
        )
    ]
)
