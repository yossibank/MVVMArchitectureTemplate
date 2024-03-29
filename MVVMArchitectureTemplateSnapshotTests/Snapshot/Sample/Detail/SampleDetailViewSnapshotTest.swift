import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

@MainActor
final class SampleDetailViewSnapshotTest: FBSnapshotTestCase {
    private var subject: SampleDetailViewController!

    override func setUp() {
        super.setUp()

        folderName = "Sample詳細画面"

        recordMode = SnapshotTest.recordMode
    }

    override func tearDown() {
        super.tearDown()

        subject = nil
    }

    func testSampleDetail_標準() {
        snapshotVerifyView(
            modelObject: SampleModelObjectBuilder()
                .build()
        )
    }

    func testSampleDetailView_タイトル_長文() {
        snapshotVerifyView(
            modelObject: SampleModelObjectBuilder()
                .title(String(repeating: "sample title", count: 20))
                .build()
        )
    }

    func testSampleDetailView_内容_長文() {
        snapshotVerifyView(
            modelObject: SampleModelObjectBuilder()
                .body(String(repeating: "sample body", count: 20))
                .build()
        )
    }

    func testSampleDetailView_タイトル_内容_長文() {
        snapshotVerifyView(
            modelObject: SampleModelObjectBuilder()
                .title(String(repeating: "sample title", count: 20))
                .body(String(repeating: "sample body", count: 20))
                .build()
        )
    }
}

private extension SampleDetailViewSnapshotTest {
    func snapshotVerifyView(modelObject: SampleModelObject) {
        let request = SampleDetailScreenRequest(modelObject: modelObject)
        let vc = RouterService().buildViewController(request: request)
        subject = vc

        snapshotVerifyView(
            viewMode: .viewController(subject),
            viewAfter: 0.2
        )
    }
}
