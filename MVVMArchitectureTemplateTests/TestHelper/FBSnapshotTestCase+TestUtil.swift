import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

enum SnapshotTest {
    static let recordMode = false
}

enum SnapshotViewMode {
    case normal(UIViewController)
    case navigation(UIViewController)
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
        viewAction: VoidBlock? = nil
    ) {
        SnapshotColorMode.allCases.forEach { colorMode in
            snapshotVerifyView(
                colorMode: colorMode,
                viewMode: viewMode,
                viewFrame: viewFrame,
                viewAfter: viewAfter,
                viewAction: viewAction
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
        let window: UIWindow

        switch viewMode {
        case let .normal(viewController):
            viewController.view.frame = viewFrame
            window = .init(frame: viewFrame)
            window.rootViewController = viewController

        case let .navigation(viewController):
            viewController.view.frame = viewFrame
            window = .init(frame: viewFrame)
            window.rootViewController = UINavigationController(rootViewController: viewController)
        }

        viewAction?()

        window.makeKeyAndVisible()
        window.rootViewController?.view.layoutIfNeeded()
        window.overrideUserInterfaceStyle = colorMode == .light ? .light : .dark

        DispatchQueue.main.asyncAfter(deadline: .now() + viewAfter) {
            self.FBSnapshotVerifyView(
                window,
                identifier: colorMode.identifier,
                file: file,
                line: line
            )

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0 + viewAfter)
    }
}
