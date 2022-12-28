import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate

final class SampleAddViewControllerSnapshotTest: FBSnapshotTestCase {
    private var subject: SampleAddViewController!

    override func setUp() {
        super.setUp()

        folderName = "Sample追加画面"

        recordMode = SnapshotRecordMode.recordMode

        subject = AppControllers.Sample.Add()
    }

    func testSampleAddViewController_作成ボタン_有効化() {
        SnapshotColorMode.allCases.forEach { mode in
            snapshotWindow(subject: subject, mode: mode) {
                self.subject.viewModel.binding.title = "title"
                self.subject.viewModel.binding.body = "body"
            }
            snapshotVerifyView(subject: subject, identifier: mode.identifier)
        }
    }

    func testSampleAddViewController_作成ボタン_無効化() {
        SnapshotColorMode.allCases.forEach { mode in
            snapshotWindow(subject: subject, mode: mode)
            snapshotVerifyView(subject: subject, identifier: mode.identifier)
        }
    }

    func testSampleAddViewController_バリデーション_タイトル_空文字() {
        SnapshotColorMode.allCases.forEach { mode in
            snapshotWindow(subject: subject, mode: mode) {
                self.subject.viewModel.binding.title = ""
            }
            snapshotVerifyView(subject: subject, identifier: mode.identifier)
        }
    }

    func testSampleAddViewController_バリデーション_内容_空文字() {
        SnapshotColorMode.allCases.forEach { mode in
            snapshotWindow(subject: subject, mode: mode) {
                self.subject.viewModel.binding.body = ""
            }
            snapshotVerifyView(subject: subject, identifier: mode.identifier)
        }
    }

    func testSampleAddViewController_バリデーション_タイトル_内容_空文字() {
        SnapshotColorMode.allCases.forEach { mode in
            snapshotWindow(subject: subject, mode: mode) {
                self.subject.viewModel.binding.title = ""
                self.subject.viewModel.binding.body = ""
            }
            snapshotVerifyView(subject: subject, identifier: mode.identifier)
        }
    }
}
