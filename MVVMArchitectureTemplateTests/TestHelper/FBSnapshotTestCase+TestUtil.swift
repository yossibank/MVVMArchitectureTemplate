import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

enum SnapshotTest {
    static let recordMode = false
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
        subject: UIViewController,
        completion: VoidBlock? = nil
    ) {
        SnapshotColorMode.allCases.forEach { mode in
            snapshotWindow(
                subject: subject,
                mode: mode,
                completion: completion
            )

            snapshotVerifyView(
                subject: subject,
                identifier: mode.identifier
            )
        }
    }
}

private extension FBSnapshotTestCase {
    func snapshotWindow(
        subject: UIViewController,
        window: UIWindow = UIWindow(frame: UIScreen.main.bounds),
        mode: SnapshotColorMode,
        completion: VoidBlock? = nil
    ) {
        window.rootViewController = subject
        window.overrideUserInterfaceStyle = .init(rawValue: mode.rawValue)!
        window.makeKeyAndVisible()
        completion?()
    }

    func snapshotVerifyView(
        subject: UIViewController,
        identifier: String
    ) {
        fileNameOptions = [.device, .OS, .screenSize, .screenScale]

        let expectation = XCTestExpectation(description: #function)

        DispatchQueue.main.async {
            self.FBSnapshotVerifyView(
                subject.view,
                identifier: identifier
            )

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)
    }
}
