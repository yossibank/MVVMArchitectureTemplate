import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

final class SampleEditViewControllerSnapshotTest: FBSnapshotTestCase {
    private var subject: SampleEditView!

    override func setUp() {
        super.setUp()

        folderName = "Sample編集画面"

        recordMode = SnapshotTest.recordMode
    }

    func testSampleEditViewController_編集_有効() {
        snapshotVerifyView()
    }

    func testSampleEditViewController_編集_無効() {
        snapshotVerifyView(
            modelObject: SampleModelObjectBuilder()
                .title("")
                .body("")
                .build()
        )
    }
}

private extension SampleEditViewControllerSnapshotTest {
    func snapshotVerifyView(modelObject: SampleModelObject = SampleModelObjectBuilder().build()) {
        subject = .init(modelObject: modelObject)

        snapshotVerifyView(
            viewMode: .swiftui(.navigation(subject)),
            viewAfter: 0.2
        )
    }
}
