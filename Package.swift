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
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.2")
    ],
    targets: [
        .binaryTarget(name: "Stipop", path: "Sources/Stipop.xcframework")
    ]
)
