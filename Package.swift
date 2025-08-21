// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Yscoco",
    defaultLocalization: "en",
    platforms: [.iOS(.v18), .macOS(.v15), .watchOS(.v11), .tvOS(.v18), .visionOS(.v2)],
    products: [
        .library(name: "Yscoco", targets: ["Yscoco"]),
        .library(name: "YscocoOC", targets: ["YscocoOC"]),
    ],
    dependencies: [
        .package(url: "https://github.com/devxoul/Then", branch: "master"),
        .package(url: "https://github.com/ReactiveX/RxSwift", branch: "main"),
        .package(url: "https://github.com/SnapKit/SnapKit", branch: "develop"),
        .package(url: "https://github.com/airbnb/lottie-ios", branch: "master"),
        .package(url: "https://github.com/SDWebImage/SDWebImage", branch: "master"),
        .package(url: "https://github.com/SVProgressHUD/SVProgressHUD", branch: "master"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", branch: "main"),
    ],
    targets: [
        .target(name: "Yscoco",
                dependencies: ["Then",
                               "RxSwift",
                               .target(name: "YscocoOC"),
                               .product(name: "RxCocoa", package: "RxSwift"),
                              ],
                exclude: [],
                resources: [
                    
                            ],
                swiftSettings: [.swiftLanguageMode(.v5),
                                // .unsafeFlags(["-suppress-warnings"]),
                                .define("PACKAGECONFIGURATION_DEBUG", .when(configuration: .debug)),
                                .define("PACKAGECONFIGURATION_RELEASE", .when(configuration: .release)),
                                .unsafeFlags([
                                    "-Xfrontend",
                                    "-warn-long-function-bodies=50",
                                    "-Xfrontend",
                                    "-warn-long-expression-type-checking=50"
                                ]),
                                //.treatAllWarnings(as: .error)
                                //.treatWarning("DeprecatedDeclaration", as: .warning),
                                //.treatWarning("StrictMemorySafety", as: .error),
                               ]
               ),
        .target(name: "YscocoOC",
                dependencies: [],
                path: "Sources/YscocoOC",
                exclude: [],
                resources: [],
                publicHeadersPath: ".",
                cSettings: []
                // cSettings: [.unsafeFlags(["-w"])]),
               ),
        .testTarget(name: "YscocoTests", dependencies: ["Yscoco",
                                                       "YscocoOC",
                                                       ],
                    exclude: [],
                    resources: [],
                    swiftSettings: [.swiftLanguageMode(.v5)]
                   ),
        .testTarget(name: "YscocoOCTests",
                    dependencies: ["Yscoco",
                                   "YscocoOC"
                                  ],
                    exclude: [],
                    resources: [],
                    cSettings: [])
    ],
    swiftLanguageModes: [.v6, .v5]
)
