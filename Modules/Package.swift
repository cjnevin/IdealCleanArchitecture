// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "LoginInfrastructure", targets: ["LoginInfrastructure"]),
        .library(name: "UserInfrastructure", targets: ["UserInfrastructure"]),
        .library(name: "HomePresentation", targets: ["HomePresentation"]),
        .library(name: "LoginPresentation", targets: ["LoginPresentation"]),
        .library(name: "SettingsPresentation", targets: ["SettingsPresentation"]),
        .library(name: "UserPresentation", targets: ["UserPresentation"]),
        .library(name: "HomeScene", targets: ["HomeScene"]),
        .library(name: "LoginScene", targets: ["LoginScene"]),
        .library(name: "SettingsScene", targets: ["SettingsScene"]),
        .library(name: "SharedScene", targets: ["SharedScene"]),
        .library(name: "UserScene", targets: ["UserScene"])
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
        
        .target(name: "LoginInfrastructure", dependencies: [
            "Domain"
        ], path: "Infrastructure/Login"),
        .target(name: "UserInfrastructure", dependencies: [
            "Domain"
        ], path: "Infrastructure/User"),
        
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
        
        .target(name: "HomeScene", dependencies: [
            "Domain",
            "HomePresentation",
            "SharedScene",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "Scene/Home"),
        .target(name: "LoginScene", dependencies: [
            "Domain",
            "LoginPresentation",
            "SharedScene",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "Scene/Login"),
        .target(name: "SettingsScene", dependencies: [
            "Domain",
            "SettingsPresentation",
            "SharedScene",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "Scene/Settings"),
        .target(name: "SharedScene", dependencies: [
            "Domain",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "Scene/Shared"),
        .target(name: "UserScene", dependencies: [
            "Domain",
            "UserPresentation",
            "SharedScene",
            .product(name: "AutoLayoutBuilder", package: "AutoLayoutBuilder")
        ], path: "Scene/User"),
    ]
)
