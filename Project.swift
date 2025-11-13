import ProjectDescription

let project = Project(
    name: "DesignKit",
    organizationName: "m",
    settings: .settings(
        defaultSettings: .recommended
    ),
    targets: [
        .target(
            name: "DesignKit",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "m.designkit",
            sources: [
                "Sources/**"
            ],
            dependencies: [
                // No external dependencies - pure SwiftUI
            ],
            settings: .settings(
                base: [
                    "SWIFT_VERSION": "5.0",
                    "IPHONEOS_DEPLOYMENT_TARGET": "26.0"
                ],
                configurations: [
                    .debug(name: "Debug"),
                    .release(name: "Release")
                ],
                defaultSettings: .recommended
            )
        ),
        .target(
            name: "DesignKitTests",
            destinations: [.iPhone, .iPad, .mac],
            product: .unitTests,
            bundleId: "m.designkit.tests",
            sources: [
                "Tests/**"
            ],
            dependencies: [
                .target(name: "DesignKit")
            ]
        )
    ]
)

