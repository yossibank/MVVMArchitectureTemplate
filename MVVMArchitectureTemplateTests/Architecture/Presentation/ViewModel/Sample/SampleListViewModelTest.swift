import Combine
@testable import MVVMArchitectureTemplate
import XCTest

@MainActor
final class SampleListViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var router: SampleListRouterInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleListViewModel!

    private var faEvent: FAEvent?

    override func setUp() {
        super.setUp()

        model = .init()
        router = .init()
        analytics = .init(screenId: .sampleList)

        analytics.sendEventFAEventHandler = { event in
            self.faEvent = event
        }

        viewModel = .init(
            router: router,
            model: model,
            analytics: analytics
        )
    }

    func test_ViewModel初期化_FA_screenViewイベントを送信できていること() {
        XCTAssertEqual(
            faEvent,
            .screenView
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
            viewModel.modelObjects,
            [SampleModelObjectBuilder().build()]
        )
    }

    func test_fetch_失敗_appErrorに値が代入されること() async {
        // arrange
        model.getHandler = { _ in
            throw AppError(error: .decodeError)
        }

        // act
        await viewModel.fetch()

        // assert
        XCTAssertEqual(
            viewModel.appError,
            .init(error: .decodeError)
        )
    }
}
