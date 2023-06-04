import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

final class SampleDetailViewControllerSnapshotTest: FBSnapshotTestCase {
    private var subject: SampleDetailView!

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
        subject = SampleDetailView(modelObject: modelObject)

        snapshotVerifyView(
            viewMode: .swiftui(.navigation(subject)),
            viewAfter: 0.2
        )
    }
}
