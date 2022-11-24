// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "LoginFeature", targets: ["LoginFeature"]),
        .library(name: "UserFeature", targets: ["UserFeature"]),
        .library(name: "HomeFeature", targets: ["HomeFeature"]),
        .library(name: "SettingsFeature", targets: ["SettingsFeature"]),
        .library(name: "SharedFeature", targets: ["SharedFeature"]),
        .library(name: "LoginService", targets: ["LoginService"]),
        .library(name: "LoginServiceLive", targets: ["LoginServiceLive"]),
        .library(name: "UserService", targets: ["UserService"]),
        .library(name: "UserServiceLive", targets: ["UserServiceLive"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/cjnevin/DependencyContainer", from: "1.0.1"),
        .package(url: "https://github.com/cjnevin/Assert", from: "1.0.3"),
        .package(url: "https://github.com/cjnevin/AutoLayoutBuilder", from: "1.1.0"),
        .package(url: "https://github.com/cjnevin/PhantomTypes", from: "1.0.8"),
        .package(url: "https://github.com/cjnevin/PropertyWrappers", from: "1.0.2")
    ],
    targets: [
        .target(name: "SharedFeature", dependencies: [
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ]),
        
        .target(name: "AppFeature", dependencies: [
            "HomeFeature",
            "LoginFeature",
            "SettingsFeature",
            "UserFeature",
            "LoginService",
            "LoginServiceLive",
            "UserService",
            "UserServiceLive",
        ]),
        
        .target(name: "UserFeature", dependencies: [
            "SharedFeature",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder"),
            .product(name: "DependencyContainer", package: "DependencyContainer"),
        ]),
        .testTarget(name: "UserFeatureTests", dependencies: [
            "UserFeature",
            "UserService",
            .product(name: "Assert", package: "Assert")
        ]),
        
        .target(name: "LoginFeature", dependencies: [
            "SharedFeature",
            "LoginService",
            "UserService",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder"),
            .product(name: "DependencyContainer", package: "DependencyContainer"),
        ]),
        .testTarget(name: "LoginFeatureTests", dependencies: [
            "LoginFeature",
            "LoginService",
            "UserFeature",
            "UserService",
            .product(name: "Assert", package: "Assert")
        ]),
        
        .target(name: "SettingsFeature", dependencies: [
            "SharedFeature",
            "HomeFeature",
            "LoginFeature",
            
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder"),
        ]),
        .target(name: "HomeFeature", dependencies: [
            "SharedFeature",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder"),
            .product(name: "DependencyContainer", package: "DependencyContainer"),
        ]),
        
        .target(name: "LoginService", dependencies: [
            "UserService",
            .product(name: "DependencyContainer", package: "DependencyContainer"),
            .product(name: "PhantomTypes", package: "PhantomTypes"),
            .product(name: "PropertyWrappers", package: "PropertyWrappers"),
        ]),
        .target(name: "LoginServiceLive", dependencies: [
            "LoginService",
            "UserService"
        ]),
        .testTarget(name: "LoginServiceTests", dependencies: [
            "LoginService",
            .product(name: "Assert", package: "Assert")
        ]),
        
        .target(name: "UserService", dependencies: [
            .product(name: "DependencyContainer", package: "DependencyContainer"),
            .product(name: "PhantomTypes", package: "PhantomTypes"),
            .product(name: "PropertyWrappers", package: "PropertyWrappers"),
        ]),
        .target(name: "UserServiceLive", dependencies: [
            "UserService"
        ]),
        .testTarget(name: "UserServiceTests", dependencies: [
            "UserService",
            .product(name: "Assert", package: "Assert")
        ]),
    ]
)
