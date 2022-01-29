// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CLibSwe",
    products: [
        .library(
                name: "libswe",
                targets: ["libswe"]
        )
    ],
    dependencies: [],
targets: [
    .target(name: "libswe", path: "./Sources/libswe")
]
)
/*
    targets: [
        .systemLibrary(name: "libswe")
    ]

 */