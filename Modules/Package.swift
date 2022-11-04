// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "CommonCore", targets: ["CommonCore"]),
        .library(name: "CommonUI", targets: ["CommonUI"]),
        .library(name: "LoginCore", targets: ["LoginCore"]),
        .library(name: "LoginUI", targets: ["LoginUI"]),
        .library(name: "UserCore", targets: ["UserCore"]),
        .library(name: "UserUI", targets: ["UserUI"])
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
        .target(name: "LoginCore", dependencies: [
            "CommonCore",
            "UserCore",
            .product(name: "DependencyContainer", package: "DependencyContainer"),
            .product(name: "PhantomTypes", package: "PhantomTypes"),
            .product(name: "WrappedTypes", package: "WrappedTypes"),
            .product(name: "PropertyWrappers", package: "PropertyWrappers")
        ], path: "Login/Core"),
        .target(name: "UserCore", dependencies: [
            "CommonCore",
            .product(name: "DependencyContainer", package: "DependencyContainer"),
            .product(name: "PhantomTypes", package: "PhantomTypes"),
            .product(name: "WrappedTypes", package: "WrappedTypes"),
            .product(name: "PropertyWrappers", package: "PropertyWrappers")
        ], path: "User/Core"),
        .target(name: "LoginUI", dependencies: [
            "LoginCore",
            "CommonUI",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "Login/UI"),
        .target(name: "CommonCore", dependencies: [

        ], path: "Common/Core"),
        .target(name: "CommonUI", dependencies: [
            "CommonCore",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "Common/UI"),
        .target(name: "UserUI", dependencies: [
            "UserCore",
            "CommonUI",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "User/UI"),
        .testTarget(name: "LoginCoreTests", dependencies: [
            "LoginCore",
            "UserCore",
            .product(name: "Assert", package: "Assert")
        ], path: "Login/CoreTests"),
        .testTarget(name: "UserCoreTests", dependencies: [
            "UserCore",
            .product(name: "Assert", package: "Assert")
        ], path: "User/CoreTests"),
    ]
)
