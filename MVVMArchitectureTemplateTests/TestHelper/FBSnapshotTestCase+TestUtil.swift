import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

enum SnapshotTest {
    static let recordMode = false
}

enum SnapshotViewMode {
    case navigation(UIViewController)
    case normal(UIViewController)
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
        action: VoidBlock? = nil
    ) {
        SnapshotColorMode.allCases.forEach { colorMode in
            snapshotVerifyView(
                colorMode: colorMode,
                viewMode: viewMode,
                viewFrame: viewFrame,
                action: action
            )
        }
    }
}

private extension FBSnapshotTestCase {
    func snapshotVerifyView(
        colorMode: SnapshotColorMode,
        viewMode: SnapshotViewMode,
        viewFrame: CGRect = UIScreen.main.bounds,
        action: VoidBlock? = nil
    ) {
        fileNameOptions = [.device, .OS, .screenSize, .screenScale]

        let expectation = XCTestExpectation(description: #function)

        switch viewMode {
        case let .normal(vc):
            vc.view.frame = viewFrame

            let window = UIWindow(frame: vc.view.frame)
            window.rootViewController = vc
            window.overrideUserInterfaceStyle = .init(rawValue: colorMode.rawValue)!
            window.makeKeyAndVisible()

            action?()

            DispatchQueue.main.async {
                self.FBSnapshotVerifyView(
                    vc.view,
                    identifier: colorMode.identifier
                )

                expectation.fulfill()
            }

        case let .navigation(vc):
            vc.view.frame = viewFrame

            let window = UIWindow(frame: vc.view.frame)
            let nc = UINavigationController(rootViewController: vc)
            window.rootViewController = nc
            window.overrideUserInterfaceStyle = .init(rawValue: colorMode.rawValue)!
            window.makeKeyAndVisible()

            action?()

            DispatchQueue.main.async {
                self.FBSnapshotVerifyView(
                    nc.view,
                    identifier: colorMode.identifier
                )

                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }
}
