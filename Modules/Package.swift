// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "Infrastructure", targets: ["Infrastructure"]),
        .library(name: "HomePresentation", targets: ["HomePresentation"]),
        .library(name: "LoginPresentation", targets: ["LoginPresentation"]),
        .library(name: "SettingsPresentation", targets: ["SettingsPresentation"]),
        .library(name: "UserPresentation", targets: ["UserPresentation"]),
        .library(name: "Scene", targets: ["Scene"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/cjnevin/DependencyContainer", from: "1.0.1"),
        .package(url: "https://github.com/cjnevin/Assert", from: "1.0.3"),
        .package(url: "https://github.com/cjnevin/AutoLayoutBuilder", from: "1.1.0"),
        .package(url: "https://github.com/cjnevin/PhantomTypes", from: "1.0.8"),
        .package(url: "https://github.com/cjnevin/PropertyWrappers", from: "1.0.2"),
    ],
    targets: [
        .target(name: "Domain", dependencies: [
            .product(name: "DependencyContainer", package: "DependencyContainer"),
            .product(name: "PhantomTypes", package: "PhantomTypes"),
            .product(name: "PropertyWrappers", package: "PropertyWrappers"),
        ], path: "Domain"),
        .testTarget(name: "DomainTests", dependencies: [
            "Domain",
            .product(name: "Assert", package: "Assert")
        ], path: "DomainTests"),
        
        .target(name: "Infrastructure", dependencies: [
            "Domain"
        ], path: "Infrastructure"),
        
        .target(name: "HomePresentation", dependencies: [
            "Domain"
        ], path: "Presentation/Home"),
        .target(name: "LoginPresentation", dependencies: [
            "Domain"
        ], path: "Presentation/Login"),
        .target(name: "SettingsPresentation", dependencies: [
            "Domain"
        ], path: "Presentation/Settings"),
        .target(name: "UserPresentation", dependencies: [
            "Domain"
        ], path: "Presentation/User"),
        .testTarget(name: "UserPresentationTests", dependencies: [
            "Domain",
            "UserPresentation",
            .product(name: "Assert", package: "Assert")
        ], path: "Presentation/UserTests"),
        
        .target(name: "Scene", dependencies: [
            "Domain",
            "HomePresentation",
            "LoginPresentation",
            "SettingsPresentation",
            "UserPresentation",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "Scene"),
    ]
)
