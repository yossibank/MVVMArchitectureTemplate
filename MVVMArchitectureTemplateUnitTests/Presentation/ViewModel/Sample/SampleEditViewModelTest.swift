@testable import MVVMArchitectureTemplate
import XCTest

@MainActor
final class SampleEditViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleEditViewModel!

    override func setUp() {
        super.setUp()

        model = .init()
        analytics = .init(screenId: .sampleEdit)
        viewModel = .init(
            state: .init(modelObject: SampleModelObjectBuilder().build()),
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

    func test_initialize_modelObject() {
        // assert
        XCTAssertEqual(
            viewModel.state.modelObject.title,
            "sample title"
        )

        XCTAssertEqual(
            viewModel.state.modelObject.body,
            "sample body"
        )
    }

    func test_title_validation_empty() {
        // arrange
        let title = ""

        // act
        viewModel.state.modelObject.title = title

        // assert
        XCTAssertEqual(
            viewModel.state.titleError,
            .empty
        )
    }

    func test_body_validation_empty() {
        // arrange
        let body = ""

        // act
        viewModel.state.modelObject.body = body

        // assert
        XCTAssertEqual(
            viewModel.state.bodyError,
            .empty
        )
    }

    func test_title_body_isEnabled_validation_false() {
        // arrange
        let title = ""
        let body = String(repeating: "b", count: 15)

        // act
        viewModel.state.modelObject.title = title
        viewModel.state.modelObject.body = body

        // assert
        XCTAssertFalse(viewModel.state.isEnabled)
    }

    func test_title_body_isEnabled_validation_true() {
        // arrange
        let title = String(repeating: "a", count: 15)
        let body = String(repeating: "b", count: 15)

        // act
        viewModel.state.modelObject.title = title
        viewModel.state.modelObject.body = body

        // assert
        XCTAssertTrue(viewModel.state.isEnabled)
    }

    func test_update_success() async {
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
            viewModel.state.successObject,
            SampleModelObjectBuilder()
                .title("sample edit title")
                .body("sample edit body")
                .build()
        )
    }

    func test_update_failure() async {
        // arrange
        model.putHandler = { _, _ in
            throw AppError(apiError: .invalidStatusCode(400))
        }

        // act
        await viewModel.update()

        // assert
        XCTAssertEqual(
            viewModel.state.appError,
            .init(apiError: .invalidStatusCode(400))
        )
    }
}
