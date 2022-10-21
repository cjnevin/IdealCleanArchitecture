// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserEntity",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UserEntity",
            targets: ["UserEntity"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "PhantomTypes", url: "https://github.com/cjnevin/PhantomTypes", from: "1.0.6"),
        .package(name: "PropertyWrappers", url: "https://github.com/cjnevin/PropertyWrappers", from: "1.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "UserEntity",
            dependencies: ["PhantomTypes", "PropertyWrappers"]),
        .testTarget(
            name: "UserEntityTests",
            dependencies: ["UserEntity"]),
    ]
)
