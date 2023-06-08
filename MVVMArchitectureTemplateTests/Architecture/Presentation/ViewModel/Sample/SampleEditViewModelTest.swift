@testable import MVVMArchitectureTemplate
import XCTest

@MainActor
final class SampleEditViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleEditViewModel!
    private var event: FAEvent!

    override func setUp() {
        super.setUp()

        model = .init()
        analytics = .init(screenId: .sampleEdit)

        analytics.sendEventFAEventHandler = { event in
            self.event = event
        }

        viewModel = .init(
            modelObject: SampleModelObjectBuilder().build(),
            model: model,
            analytics: analytics
        )
    }

    func test_ViewModel初期化_FA_screenViewイベントを送信できること() {
        // assert
        XCTAssertEqual(
            event,
            .screenView
        )
    }

    func test_ViewModel初期化_modelObjectがtitle_bodyに初期注入されていること() {
        // assert
        XCTAssertEqual(
            viewModel.title,
            "sample title"
        )

        XCTAssertEqual(
            viewModel.body,
            "sample body"
        )
    }

    func test_title_空文字の場合_titleErrorがemptyを出力すること() {
        // arrange
        let title = ""

        // act
        viewModel.title = title

        // assert
        XCTAssertEqual(
            viewModel.titleError,
            .empty
        )
    }

    func test_body_空文字の場合_bodyErrorがemptyを出力すること() {
        // arrange
        let body = ""

        // act
        viewModel.body = body

        // assert
        XCTAssertEqual(
            viewModel.bodyError,
            .empty
        )
    }

    func test_titleError_bodyErrorのどちらかがnoneでない場合_isEnabledがfalseを出力すること() {
        // arrange
        let title = ""
        let body = String(repeating: "b", count: 15)

        // act
        viewModel.title = title
        viewModel.body = body

        // assert
        XCTAssertFalse(viewModel.isEnabled)
    }

    func test_titleError_bodyErrorが共にnoneの場合_isEnabledがtrueを出力すること() {
        // arrange
        let title = String(repeating: "a", count: 15)
        let body = String(repeating: "b", count: 15)

        // act
        viewModel.title = title
        viewModel.body = body

        // assert
        XCTAssertTrue(viewModel.isEnabled)
    }

    func test_update_成功_successObjectに値が代入されること() async {
        // arrange
        model.putHandler = { _, _ in
            SampleModelObjectBuilder()
                .title("sample edit title")
                .body("sample edit body")
                .build()
        }

        // act
        await viewModel.update()

        // assert
        XCTAssertEqual(
            viewModel.successObject,
            SampleModelObjectBuilder()
                .title("sample edit title")
                .body("sample edit body")
                .build()
        )
    }

    func test_update_失敗_appErrorに値が代入されること() async {
        // arrange
        model.putHandler = { _, _ in
            throw AppError(apiError: .invalidStatusCode(400))
        }

        // act
        await viewModel.update()

        // assert
        XCTAssertEqual(
            viewModel.appError,
            .init(apiError: .invalidStatusCode(400))
        )
    }
}
