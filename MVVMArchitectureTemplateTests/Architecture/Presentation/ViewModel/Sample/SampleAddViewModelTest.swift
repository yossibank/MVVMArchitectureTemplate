import Combine
@testable import MVVMArchitectureTemplate
import XCTest

final class SampleAddViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleAddViewModel!

    override func setUp() {
        super.setUp()

        model = .init()
        analytics = .init(screenId: .sampleAdd)
        viewModel = .init(
            model: model,
            analytics: analytics
        )
    }

    func test_input_onAppear_FA_screenViewイベントを送信できていること() {
        // arrange
        let expectation = XCTestExpectation(description: #function)

        analytics.sendEventFAEventHandler = { event in
            // assert
            XCTAssertEqual(event, .screenView)
            expectation.fulfill()
        }

        // act
        viewModel.input.onAppear.send(())

        wait(for: [expectation], timeout: 0.1)
    }

    func test_binding_title_1文字以上20文字以下の場合にoutput_titleErrorがnoneを出力すること() {
        // arrange
        let title = String(repeating: "a", count: 10)

        // act
        viewModel.binding.title = title

        // assert
        XCTAssertEqual(
            viewModel.output.titleError,
            .none
        )

        XCTAssertEqual(
            viewModel.output.titleError.description,
            ""
        )
    }

    func test_binding_title_空文字の場合にoutput_titleErrorがemptyを出力すること() {
        // arrange
        let title = ""

        // act
        viewModel.binding.title = title

        // assert
        XCTAssertEqual(
            viewModel.output.titleError,
            .empty
        )

        XCTAssertEqual(
            viewModel.output.titleError.description,
            "文字が入力されていません。"
        )
    }

    func test_binding_title_21文字以上の場合にoutput_titleErrorがlongを出力すること() {
        // arrange
        let title = String(repeating: "a", count: 21)

        // act
        viewModel.binding.title = title

        // assert
        XCTAssertEqual(
            viewModel.output.titleError,
            .long
        )

        XCTAssertEqual(
            viewModel.output.titleError.description,
            "入力された文字が長すぎます。20文字以内でご入力ください。"
        )
    }

    func test_binding_body_1文字以上20文字以下の場合にoutput_bodyErrorがnoneを出力すること() {
        // arrange
        let body = String(repeating: "a", count: 10)

        // act
        viewModel.binding.body = body

        // assert
        XCTAssertEqual(
            viewModel.output.bodyError,
            .none
        )

        XCTAssertEqual(
            viewModel.output.bodyError.description,
            ""
        )
    }

    func test_binding_body_空文字の場合にoutput_bodyErrorがemptyを出力すること() {
        // arrange
        let body = ""

        // act
        viewModel.binding.body = body

        // assert
        XCTAssertEqual(
            viewModel.output.bodyError,
            .empty
        )

        XCTAssertEqual(
            viewModel.output.bodyError.description,
            "文字が入力されていません。"
        )
    }

    func test_binding_body_21文字以上の場合にoutput_bodyErrorがlongを出力すること() {
        // arrange
        let body = String(repeating: "a", count: 21)

        // act
        viewModel.binding.body = body

        // assert
        XCTAssertEqual(
            viewModel.output.bodyError,
            .long
        )

        XCTAssertEqual(
            viewModel.output.bodyError.description,
            "入力された文字が長すぎます。20文字以内でご入力ください。"
        )
    }

    func test_titleError_bodyErrorのどちらかがnoneでない場合_output_isEnabledがfalseを出力すること() {
        // arrange
        let title = ""
        let body = String(repeating: "b", count: 15)

        // act
        viewModel.binding.title = title
        viewModel.binding.body = body

        // assert
        XCTAssertFalse(viewModel.output.isEnabled)
    }

    func test_titleError_bodyErrorが共にnoneの場合_output_isEnabledがtrueを出力すること() {
        // arrange
        let title = String(repeating: "a", count: 15)
        let body = String(repeating: "b", count: 15)

        // act
        viewModel.binding.title = title
        viewModel.binding.body = body

        // assert
        XCTAssertTrue(viewModel.output.isEnabled)
    }

    func test_input_didTapCreateButton_成功_登録ボタンをタップした際に入力情報を登録できること() throws {
        // arrange
        model.postHandler = { _ in
            Future<SampleModelObject, AppError> { promise in
                promise(.success(SampleModelObjectBuilder().build()))
            }
            .eraseToAnyPublisher()
        }

        let title = String(repeating: "a", count: 15)
        let body = String(repeating: "b", count: 15)

        viewModel.binding.title = title
        viewModel.binding.body = body

        // act
        viewModel.input.didTapCreateButton.send(())

        let publisher = viewModel.output.$modelObject.dropFirst().collect(1).first()
        let output = try awaitOutputPublisher(publisher).first

        // assert
        XCTAssertEqual(
            output,
            SampleModelObjectBuilder().build()
        )
    }

    func test_input_didTapCreateButton_失敗_登録ボタンをタップした際にエラー情報を取得できること() throws {
        // arrange
        model.postHandler = { _ in
            Future<SampleModelObject, AppError> { promise in
                promise(.failure(.init(apiError: .invalidStatusCode(400))))
            }
            .eraseToAnyPublisher()
        }

        let title = String(repeating: "a", count: 15)
        let body = String(repeating: "b", count: 15)

        viewModel.binding.title = title
        viewModel.binding.body = body

        // act
        viewModel.input.didTapCreateButton.send(())

        let publisher = viewModel.output.$appError.dropFirst().collect(1).first()
        let output = try awaitOutputPublisher(publisher).first

        // assert
        XCTAssertEqual(
            output,
            .init(apiError: .invalidStatusCode(400))
        )
    }
}
