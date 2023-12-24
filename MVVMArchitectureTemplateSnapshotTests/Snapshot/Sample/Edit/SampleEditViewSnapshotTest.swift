import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

@MainActor
final class SampleEditViewSnapshotTest: FBSnapshotTestCase {
    private var viewModel: SampleEditViewModel!
    private var subject: SampleEditViewController!

    override func setUp() {
        super.setUp()

        folderName = "Sample編集画面"

        recordMode = SnapshotTest.recordMode
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        subject = nil
    }

    func testSampleEditView_編集_有効() {
        snapshotVerifyView()
    }

    func testSampleEditView_編集_無効() {
        snapshotVerifyView(
            modelObject: SampleModelObjectBuilder()
                .title("")
                .body("")
                .build()
        )
    }
}

private extension SampleEditViewSnapshotTest {
    func snapshotVerifyView(modelObject: SampleModelObject = SampleModelObjectBuilder().build()) {
        viewModel = .init(
            state: .init(modelObject: modelObject),
            dependency: .init(
                model: SampleModelInputMock(),
                analytics: FirebaseAnalytics(screenId: .sampleEdit)
            )
        )

        subject = .init(
            rootView: .init(viewModel: viewModel),
            viewModel: viewModel
        )

        snapshotVerifyView(
            viewMode: .viewController(subject),
            viewAfter: 0.2
        )
    }
}
