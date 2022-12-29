import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

final class SampleDetailViewControllerSnapshotTest: FBSnapshotTestCase {
    private var rootViewController: SampleDetailViewController!

    override func setUp() {
        super.setUp()

        folderName = "Sample詳細画面"

        recordMode = SnapshotTest.recordMode
    }

    func testSampleDetailViewController_標準() {
        snapshotVerifyView(
            modelObject: SampleModelObjectBuilder()
                .build()
        )
    }

    func testSampleDetailViewController_タイトル_長文() {
        snapshotVerifyView(
            modelObject: SampleModelObjectBuilder()
                .title(String(repeating: "sample title", count: 20))
                .build()
        )
    }

    func testSampleDetailViewController_内容_長文() {
        snapshotVerifyView(
            modelObject: SampleModelObjectBuilder()
                .body(String(repeating: "sample body", count: 20))
                .build()
        )
    }

    func testSampleDetailViewController_タイトル_内容_長文() {
        snapshotVerifyView(
            modelObject: SampleModelObjectBuilder()
                .title(String(repeating: "sample title", count: 20))
                .body(String(repeating: "sample body", count: 20))
                .build()
        )
    }
}

private extension SampleDetailViewControllerSnapshotTest {
    func snapshotVerifyView(modelObject: SampleModelObject) {
        rootViewController = AppControllers.Sample.Detail(modelObject)
        let subject = UINavigationController(rootViewController: rootViewController)
        snapshotVerifyView(subject: subject)
    }
}
