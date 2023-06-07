import Combine
@testable import MVVMArchitectureTemplate
import XCTest

@MainActor
final class SampleAddViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleAddViewModel!
    private var event: FAEvent!

    override func setUp() {
        super.setUp()

        model = .init()
        analytics = .init(screenId: .sampleAdd)
        
        analytics.sendEventFAEventHandler = { event in
            self.event = event
        }
        
        viewModel = .init(
            model: model,
            analytics: analytics
        )
    }

    func test_ViewModel初期化_FA_screenViewイベントを送信できること() {
        XCTAssertEqual(
            event,
            .screenView
        )
    }

    func test_title_1文字以上20文字以下の場合_titleErrorがnoneを出力すること() {
        // arrange
        let title = String(repeating: "a", count: 10)

        // act
        viewModel.title = title

        // assert
        XCTAssertEqual(
            viewModel.titleError,
            .none
        )

        XCTAssertEqual(
            viewModel.titleError.description,
            ""
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

        XCTAssertEqual(
            viewModel.titleError.description,
            "文字が入力されていません。"
        )
    }

    func test_title_21文字以上の場合_titleErrorがlongを出力すること() {
        // arrange
        let title = String(repeating: "a", count: 21)

        // act
        viewModel.title = title

        // assert
        XCTAssertEqual(
            viewModel.titleError,
            .long
        )

        XCTAssertEqual(
            viewModel.titleError.description,
            "入力された文字が長すぎます。20文字以内でご入力ください。"
        )
    }

    func test_body_1文字以上20文字以下の場合_bodyErrorがnoneを出力すること() {
        // arrange
        let body = String(repeating: "a", count: 10)

        // act
        viewModel.body = body

        // assert
        XCTAssertEqual(
            viewModel.bodyError,
            .none
        )

        XCTAssertEqual(
            viewModel.bodyError.description,
            ""
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

        XCTAssertEqual(
            viewModel.bodyError.description,
            "文字が入力されていません。"
        )
    }

    func test_body_21文字以上の場合_bodyErrorがlongを出力すること() {
        // arrange
        let body = String(repeating: "a", count: 21)

        // act
        viewModel.body = body

        // assert
        XCTAssertEqual(
            viewModel.bodyError,
            .long
        )

        XCTAssertEqual(
            viewModel.bodyError.description,
            "入力された文字が長すぎます。20文字以内でご入力ください。"
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

    func test_post_成功_modelObjectに値が代入されること() async {
        // arrange
        model.postHandler = { _ in
            SampleModelObjectBuilder().build()
        }

        let title = String(repeating: "a", count: 15)
        let body = String(repeating: "b", count: 15)

        viewModel.title = title
        viewModel.body = body

        // act
        await viewModel.post()

        // assert
        XCTAssertEqual(
            viewModel.modelObject,
            SampleModelObjectBuilder().build()
        )
    }

    func test_post_失敗_appErrorに値が代入されること() async {
        // arrange
        model.postHandler = { _ in
            throw AppError(apiError: .invalidStatusCode(400))
        }

        let title = String(repeating: "a", count: 15)
        let body = String(repeating: "b", count: 15)

        viewModel.title = title
        viewModel.body = body

        // act
        await viewModel.post()

        // assert
        XCTAssertEqual(
            viewModel.appError,
            .init(apiError: .invalidStatusCode(400))
        )
    }
}
