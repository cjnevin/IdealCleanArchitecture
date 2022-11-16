// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "Core", targets: ["Core"]),
        .library(name: "UI", targets: ["UI"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/cjnevin/DependencyContainer", from: "1.0.1"),
        .package(url: "https://github.com/cjnevin/Assert", from: "1.0.2"),
        .package(url: "https://github.com/cjnevin/AutoLayoutBuilder", from: "1.1.0"),
        .package(url: "https://github.com/cjnevin/PhantomTypes", from: "1.0.8"),
        .package(url: "https://github.com/cjnevin/WrappedTypes", from: "1.0.1"),
        .package(url: "https://github.com/cjnevin/PropertyWrappers", from: "1.0.2"),
    ],
    targets: [
        .target(name: "Core", dependencies: [
            .product(name: "DependencyContainer", package: "DependencyContainer"),
            .product(name: "PhantomTypes", package: "PhantomTypes"),
            .product(name: "WrappedTypes", package: "WrappedTypes"),
            .product(name: "PropertyWrappers", package: "PropertyWrappers")
        ], path: "Core"),
        .target(name: "UI", dependencies: [
            "Core",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "UI"),
        .testTarget(name: "CoreTests", dependencies: [
            "Core",
            .product(name: "Assert", package: "Assert")
        ], path: "CoreTests"),
    ]
)
