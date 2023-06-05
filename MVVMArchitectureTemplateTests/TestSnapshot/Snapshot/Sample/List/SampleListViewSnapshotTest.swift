import iOSSnapshotTestCase
@testable import MVVMArchitectureTemplate
import OHHTTPStubs
import OHHTTPStubsSwift

@MainActor
final class SampleListViewSnapshotTest: FBSnapshotTestCase {
    private var subject: SampleListView!

    override func setUp() {
        super.setUp()

        folderName = "Sample一覧画面"

        recordMode = SnapshotTest.recordMode
    }

    override func tearDown() {
        super.tearDown()

        HTTPStubs.removeAllStubs()
    }

    func testSampleListView_少件数() {
        snapshotVerifyView(mock: .short)
    }

    func testSampleListView_中件数() {
        snapshotVerifyView(mock: .medium)
    }

    func testSampleListView_多件数() {
        snapshotVerifyView(mock: .long)
    }
}

private extension SampleListViewSnapshotTest {
    enum APIMock: String {
        case short
        case medium
        case long

        var height: CGFloat {
            let height = UIScreen.main.bounds.height

            switch self {
            case .short:
                return height

            case .medium:
                return height * 2

            case .long:
                return height * 4
            }
        }
    }

    func snapshotVerifyView(mock: APIMock) {
        stub(condition: isPath("/posts")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "snapshot_sample_list_\(mock.rawValue).json",
                    type(of: self)
                )!,
                headers: ["Content-Type": "application/json"]
            )
        }

        subject = SampleListView(viewModel: ViewModels.Sample.List())

        snapshotVerifyView(
            viewMode: .swiftui(.normal(subject)),
            viewFrame: .init(
                x: .zero,
                y: .zero,
                width: UIScreen.main.bounds.width,
                height: mock.height
            ),
            viewAfter: 0.5
        )
    }
}
