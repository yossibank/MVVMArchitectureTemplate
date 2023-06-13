import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate
import SwiftUI

enum SnapshotTest {
    static let recordMode = false
}

enum SnapshotViewMode {
    case uikit(ScreenUIKitMode)
    case swiftui(ScreenSwiftUIMode)

    enum ScreenUIKitMode {
        case normal(UIViewController)
        case navigation(UIViewController)
    }

    enum ScreenSwiftUIMode {
        case normal(any View)
        case navigation(any View)
    }
}

enum SnapshotColorMode: Int, CaseIterable {
    case light = 1
    case dark

    var identifier: String {
        switch self {
        case .light:
            return "ライトモード"

        case .dark:
            return "ダークモード"
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
        viewFrame: CGRect = UIScreen.main.bounds,
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
        viewFrame: CGRect = UIScreen.main.bounds,
        viewAfter: CGFloat = .zero,
        viewAction: VoidBlock? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        fileNameOptions = [.device, .OS, .screenSize, .screenScale]

        let expectation = XCTestExpectation(description: #function)
        let window = UIWindow(frame: viewFrame)

        switch viewMode {
        case let .uikit(screenMode):
            switch screenMode {
            case let .normal(viewController):
                window.rootViewController = viewController

            case let .navigation(viewController):
                window.rootViewController = UINavigationController(rootViewController: viewController)
            }

        case let .swiftui(screenMode):
            switch screenMode {
            case let .normal(view):
                window.rootViewController = UIHostingController(rootView: AnyView(view))

            case let .navigation(view):
                window.rootViewController = UIHostingController(rootView: NavigationView {
                    AnyView(view)
                })
            }
        }

        window.rootViewController?.view.frame = viewFrame
        window.rootViewController?.view.layoutIfNeeded()
        window.overrideUserInterfaceStyle = colorMode == .light ? .light : .dark
        window.makeKeyAndVisible()

        viewAction?()

        DispatchQueue.main.asyncAfter(deadline: .now() + viewAfter) {
            self.FBSnapshotVerifyView(
                window,
                identifier: colorMode.identifier,
                overallTolerance: 0.03,
                file: file,
                line: line
            )

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0 + viewAfter)
    }
}
