import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

@MainActor
final class SampleAddViewSnapshotTest: FBSnapshotTestCase {
    private var subject: SampleAddView!
    private var viewModel: SampleAddViewModel!

    override func setUp() {
        super.setUp()

        folderName = "Sample追加画面"

        recordMode = SnapshotTest.recordMode

        viewModel = ViewModels.Sample.Add()
    }

    func testSampleAddView_作成_有効() {
        snapshotVerifyView(
            title: "title",
            body: "body"
        )
    }

    func testSampleAddView_作成_無効() {
        snapshotVerifyView()
    }
}

private extension SampleAddViewSnapshotTest {
    func snapshotVerifyView(
        title: String = "",
        body: String = ""
    ) {
        viewModel.title = title
        viewModel.body = body
        subject = .init(viewModel: viewModel)
        snapshotVerifyView(viewMode: .swiftui(.navigation(subject)))
    }
}
