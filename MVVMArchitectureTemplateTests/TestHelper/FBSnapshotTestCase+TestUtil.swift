import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

enum SnapshotTest {
    static let recordMode = false
}

extension FBSnapshotTestCase {
    func callViewControllerAppear(vc: UIViewController) {
        vc.beginAppearanceTransition(true, animated: false)
        vc.endAppearanceTransition()
    }

    func snapshotWindow(
        subject: UIViewController,
        window: UIWindow = UIWindow(frame: UIScreen.main.bounds),
        interfaceStyle: UIUserInterfaceStyle = .light
    ) {
        window.rootViewController = subject
        window.overrideUserInterfaceStyle = interfaceStyle
        window.makeKeyAndVisible()
    }

    func snapshotVerifyView(subject: UIViewController!) {
//        subject.view.layoutIfNeeded()

        let expectation = XCTestExpectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.FBSnapshotVerifyView(subject.view, overallTolerance: 0.05)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }
}
