@testable import MVVMArchitectureTemplate
import XCTest

@MainActor
final class SampleAddViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleAddViewModel!

    override func setUp() {
        super.setUp()

        model = .init()
        analytics = .init(screenId: .sampleAdd)
        viewModel = .init(
            state: .init(),
            dependency: .init(
                model: model,
                analytics: analytics
            )
        )
    }

    func test_initialize() {
        // assert
        XCTAssertEqual(
            analytics.sendEventFAEventCallCount,
            1
        )
    }

    func test_title_validation_none() {
        // arrange
        let title = String(repeating: "a", count: 10)

        // act
        viewModel.state.title = title

        // assert
        XCTAssertEqual(
            viewModel.state.titleError,
            .none
        )

        XCTAssertEqual(
            viewModel.state.titleError.description,
            ""
        )
    }

    func test_title_validation_empty() {
        // arrange
        let title = ""

        // act
        viewModel.state.title = title

        // assert
        XCTAssertEqual(
            viewModel.state.titleError,
            .empty
        )

        XCTAssertEqual(
            viewModel.state.titleError.description,
            "文字が入力されていません。"
        )
    }

    func test_title_validation_long() {
        // arrange
        let title = String(repeating: "a", count: 21)

        // act
        viewModel.state.title = title

        // assert
        XCTAssertEqual(
            viewModel.state.titleError,
            .long
        )

        XCTAssertEqual(
            viewModel.state.titleError.description,
            "入力された文字が長すぎます。20文字以内でご入力ください。"
        )
    }

    func test_body_validation_none() {
        // arrange
        let body = String(repeating: "a", count: 10)

        // act
        viewModel.state.body = body

        // assert
        XCTAssertEqual(
            viewModel.state.bodyError,
            .none
        )

        XCTAssertEqual(
            viewModel.state.bodyError.description,
            ""
        )
    }

    func test_body_validation_empty() {
        // arrange
        let body = ""

        // act
        viewModel.state.body = body

        // assert
        XCTAssertEqual(
            viewModel.state.bodyError,
            .empty
        )

        XCTAssertEqual(
            viewModel.state.bodyError.description,
            "文字が入力されていません。"
        )
    }

    func test_body_validation_long() {
        // arrange
        let body = String(repeating: "a", count: 21)

        // act
        viewModel.state.body = body

        // assert
        XCTAssertEqual(
            viewModel.state.bodyError,
            .long
        )

        XCTAssertEqual(
            viewModel.state.bodyError.description,
            "入力された文字が長すぎます。20文字以内でご入力ください。"
        )
    }

    func test_title_body_isEnabled_validation_false() {
        // arrange
        let title = ""
        let body = String(repeating: "b", count: 15)

        // act
        viewModel.state.title = title
        viewModel.state.body = body

        // assert
        XCTAssertFalse(viewModel.state.isEnabled)
    }

    func test_title_body_isEnabled_validation_true() {
        // arrange
        let title = String(repeating: "a", count: 15)
        let body = String(repeating: "b", count: 15)

        // act
        viewModel.state.title = title
        viewModel.state.body = body

        // assert
        XCTAssertTrue(viewModel.state.isEnabled)
    }

    func test_post_success() async {
        // arrange
        model.postHandler = { _ in
            SampleModelObjectBuilder().build()
        }

        let title = String(repeating: "a", count: 15)
        let body = String(repeating: "b", count: 15)

        viewModel.state.title = title
        viewModel.state.body = body

        // act
        await viewModel.post()

        // assert
        XCTAssertEqual(
            viewModel.state.successObject,
            SampleModelObjectBuilder().build()
        )
    }

    func test_post_failure() async {
        // arrange
        model.postHandler = { _ in
            throw AppError(apiError: .invalidStatusCode(400))
        }

        let title = String(repeating: "a", count: 15)
        let body = String(repeating: "b", count: 15)

        viewModel.state.title = title
        viewModel.state.body = body

        // act
        await viewModel.post()

        // assert
        XCTAssertEqual(
            viewModel.state.appError,
            .init(apiError: .invalidStatusCode(400))
        )
    }
}
