import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

@MainActor
final class SampleAddViewSnapshotTest: FBSnapshotTestCase {
    private var viewModel: SampleAddViewModel!
    private var subject: SampleAddViewController!

    override func setUp() {
        super.setUp()

        folderName = "Sample追加画面"

        recordMode = SnapshotTest.recordMode
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        subject = nil
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
        viewModel = .init(
            state: .init(),
            dependency: .init(
                model: SampleModelInputMock(),
                analytics: FirebaseAnalytics(screenId: .sampleAdd)
            )
        )

        subject = .init(
            rootView: .init(viewModel: viewModel),
            viewModel: viewModel
        )

        viewModel.state.title = title
        viewModel.state.body = body

        snapshotVerifyView(viewMode: .viewController(subject))
    }
}
