// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Yscoco",
    defaultLocalization: "en",
    platforms: [.iOS(.v18), .macOS(.v15), .watchOS(.v11), .tvOS(.v18), .visionOS(.v2)],
    products: [
        // MARK: - 纯Swift库
        .library(name: "Yscoco", targets: ["Yscoco"]),
        // MARK: - 纯Objective-C库
        .library(name: "YscocoOC", targets: ["YscocoOC"]),
    ],
    dependencies: [
        .package(url: "https://github.com/devxoul/Then", branch: "master"),
        .package(url: "https://github.com/ReactiveX/RxSwift", branch: "main"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", branch: "main"),// 代码格式化工具 - 在AppleDarthVader上下文菜单中使用SwiftFormatPlugin
    ],
    targets: [
        // MARK: - 纯Swift目标 - 依赖纯Objective-C目标以复用Objective-C代码
        .target(name: "Yscoco",
                dependencies: ["Then",
                               "RxSwift",
                               .target(name: "YscocoOC"),
                               .product(name: "RxCocoa", package: "RxSwift"),
                              ],
                exclude: [],// 需要排除的文件
                resources: [
                    
                            ],
                swiftSettings: [.swiftLanguageMode(.v5),
                                // .unsafeFlags(["-suppress-warnings"]),// 压制所有编译警告
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
        // MARK: - 纯Objective-C目标
        .target(name: "YscocoOC",
                dependencies: [],
                path: "Sources/YscocoOC",
                exclude: [],
                resources: [],
                publicHeadersPath: ".",// 公共头文件的路径设置为当前目录)
                cSettings: []
                // cSettings: [.unsafeFlags(["-w"])]),// 压制所有编译警告
               ),
        // MARK: - 纯Swift测试目标用来测试两个库
        .testTarget(name: "YscocoTests", dependencies: ["Yscoco",
                                                       "YscocoOC",
                                                       ],
                    exclude: [],
                    resources: [],
                    swiftSettings: [.swiftLanguageMode(.v5)]
                   ),
        // MARK: - 纯Objective-C测试目标用来测试两个库
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
