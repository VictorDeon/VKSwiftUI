// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VKSwiftUI",
    platforms: [.macOS(.v15), .iOS(.v15)],
    products: [
        .library(name: "VKSwiftUI", targets: ["VKSwiftUI"]),
        .executable(name: "VKSwiftUICLI", targets: ["CLI"]),
    ],
    targets: [
        .target(name: "VKSwiftUI"),
        .executableTarget(name: "CLI", dependencies: ["VKSwiftUI"]),
        .testTarget(name: "VKSwiftUITests", dependencies: ["VKSwiftUI"]),
    ]
)
