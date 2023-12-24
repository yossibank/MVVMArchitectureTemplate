import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate
import SwiftUI

enum SnapshotTest {
    static let recordMode = false
}

enum SnapshotViewMode {
    case normal(any View)
    case navigation(any View)
    case viewController(UIViewController)
}

enum SnapshotColorMode: Int, CaseIterable {
    case light = 1
    case dark

    var identifier: String {
        switch self {
        case .light:
            "ライトモード"

        case .dark:
            "ダークモード"
        }
    }
}

extension FBSnapshotTestCase {
    func callViewControllerAppear(vc: UIViewController) {
        vc.beginAppearanceTransition(true, animated: false)
        vc.endAppearanceTransition()
    }

    func snapshotVerifyView(
        viewMode: SnapshotViewMode,
        viewFrame: CGRect = UIWindow.windowFrame,
        viewAfter: CGFloat = .zero,
        viewAction: VoidBlock? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        SnapshotColorMode.allCases.forEach { colorMode in
            snapshotVerifyView(
                colorMode: colorMode,
                viewMode: viewMode,
                viewFrame: viewFrame,
                viewAfter: viewAfter,
                viewAction: viewAction,
                file: file,
                line: line
            )
        }
    }
}

private extension FBSnapshotTestCase {
    func snapshotVerifyView(
        colorMode: SnapshotColorMode,
        viewMode: SnapshotViewMode,
        viewFrame: CGRect = UIWindow.windowFrame,
        viewAfter: CGFloat = .zero,
        viewAction: VoidBlock? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        fileNameOptions = [.device, .OS, .screenSize, .screenScale]

        let window = UIWindow(windowScene: UIWindow.connectedWindowScene!)
        window.frame = viewFrame

        switch viewMode {
        case let .normal(view):
            window.rootViewController = UIHostingController(rootView: AnyView(view))

        case let .navigation(view):
            window.rootViewController = UIHostingController(rootView: NavigationView {
                AnyView(view)
            })

        case let .viewController(vc):
            window.rootViewController = UINavigationController(rootViewController: vc)
        }

        window.overrideUserInterfaceStyle = colorMode == .light ? .light : .dark
        window.makeKeyAndVisible()

        viewAction?()

        callViewControllerAppear(vc: window.rootViewController!)

        wait(timeout: viewAfter + 3.0) { expectation in
            Task { @MainActor in
                try await Task.sleep(seconds: viewAfter)

                FBSnapshotVerifyView(
                    window,
                    identifier: colorMode.identifier,
                    overallTolerance: 0.03,
                    file: file,
                    line: line
                )

                expectation.fulfill()
            }
        }
    }
}
