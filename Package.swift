// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoordinatorKit",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "CoordinatorKit", targets: ["CoordinatorKit"]),
    ],
    targets: [
        .target(name: "CoordinatorKit", path: "Sources/CoordinatorKit"),
        .testTarget(name: "CoordinatorKitTests", dependencies: ["CoordinatorKit"]),
    ]
)
