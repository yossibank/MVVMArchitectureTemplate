import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

final class SampleAddViewControllerSnapshotTest: FBSnapshotTestCase {
    var subject: SampleAddViewController!

    override func setUp() {
        super.setUp()

        subject = AppControllers.Sample.Add()

        recordMode = false
    }

    func test_SampleAdd_初期画面() {
        snapshotWindow(subject: subject)
//        callViewControllerAppear(vc: subject)
        snapshotVerifyView(subject: subject)
    }
}
