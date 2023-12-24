@testable import MVVMArchitectureTemplate
import XCTest

@MainActor
final class SampleListViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleListViewModel!
    private var event: FAEvent!

    override func setUp() {
        super.setUp()

        model = .init()
        analytics = .init(screenId: .sampleList)
        viewModel = .init(
            state: .init(),
            dependency: .init(
                model: model,
                analytics: analytics
            )
        )
    }

    func test_fetch_成功_modelObjectsに値が代入されること() async {
        // arrange
        model.getHandler = { _ in
            [SampleModelObjectBuilder().build()]
        }

        // act
        await viewModel.fetch()

        // assert
        XCTAssertEqual(
            viewModel.state.modelObjects,
            [SampleModelObjectBuilder().build()]
        )
    }

    func test_fetch_失敗_appErrorに値が代入されること() async {
        // arrange
        model.getHandler = { _ in
            throw AppError(apiError: .decode)
        }

        // act
        await viewModel.fetch()

        // assert
        XCTAssertEqual(
            viewModel.state.appError,
            .init(apiError: .decode)
        )
    }
}
