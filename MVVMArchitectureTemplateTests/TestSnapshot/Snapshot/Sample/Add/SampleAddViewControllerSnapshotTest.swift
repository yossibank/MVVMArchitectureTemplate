import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate
import SwiftUI

final class SampleAddViewControllerSnapshotTest: FBSnapshotTestCase {
    private var subject: SampleAddView!
    private var viewModel: SampleAddViewModel!

    override func setUp() {
        super.setUp()

        folderName = "Sample追加画面"

        recordMode = SnapshotTest.recordMode

        viewModel = ViewModels.Sample.Add()
    }

    func testSampleAddViewController_作成_有効() {
        snapshotVerifyView(
            title: "title",
            body: "body"
        )
    }

    func testSampleAddViewController_作成_無効() {
        snapshotVerifyView()
    }
}

private extension SampleAddViewControllerSnapshotTest {
    func snapshotVerifyView(
        title: String = "",
        body: String = ""
    ) {
        viewModel.binding.title = title
        viewModel.binding.body = body
        subject = .init(viewModel: viewModel)
        snapshotVerifyView(viewMode: .swiftui(.navigation(subject)))
    }
}
