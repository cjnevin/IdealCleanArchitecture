// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
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
            "UserCore",
            .product(name: "DependencyContainer", package: "DependencyContainer"),
            .product(name: "PhantomTypes", package: "PhantomTypes"),
            .product(name: "WrappedTypes", package: "WrappedTypes"),
            .product(name: "PropertyWrappers", package: "PropertyWrappers")
        ], path: "Modules/Login/Core"),
        .target(name: "UserCore", dependencies: [
            .product(name: "DependencyContainer", package: "DependencyContainer"),
            .product(name: "PhantomTypes", package: "PhantomTypes"),
            .product(name: "WrappedTypes", package: "WrappedTypes"),
            .product(name: "PropertyWrappers", package: "PropertyWrappers")
        ], path: "Modules/User/Core"),
        .target(name: "LoginUI", dependencies: [
            "LoginCore",
            "UserCore",
            "CommonUI",
            "UserUI",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "Modules/Login/UI"),
        .target(name: "CommonUI", dependencies: [
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "Modules/Common/UI"),
        .target(name: "UserUI", dependencies: [
            "UserCore",
            "CommonUI",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "Modules/User/UI"),
        .testTarget(name: "LoginCoreTests", dependencies: [
            "LoginCore",
            "UserCore",
            .product(name: "Assert", package: "Assert")
        ], path: "Modules/Login/CoreTests"),
        .testTarget(name: "UserCoreTests", dependencies: [
            "UserCore",
            .product(name: "Assert", package: "Assert")
        ], path: "Modules/User/CoreTests"),
    ]
)
