import Combine
@testable import MVVMArchitectureTemplate
import XCTest

final class SampleAddViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleAddViewModel!

    func test_viewWillAppear_firebaseAnalytics_screenViewイベントを送信できていること() {
        // arrange
        setupViewModel()

        let expectation = XCTestExpectation(description: #function)

        analytics.sendEventFAEventHandler = { event in
            // assert
            XCTAssertEqual(event, .screenView)
            expectation.fulfill()
        }

        // act
        viewModel.input.viewWillAppear.send(())

        wait(for: [expectation], timeout: 0.1)
    }

    func test_binding_title_1文字以上20文字以下の場合にoutput_titleValidationがnoneを出力すること() {
        // arrange
        setupViewModel()

        // act
        viewModel.binding.title = String(repeating: "a", count: 10)

        // assert
        XCTAssertEqual(viewModel.output.titleValidation, ValidationError.none)
    }

    func test_binding_title_空文字の場合にoutput_titleValidationがemptyを出力すること() {
        // arrange
        setupViewModel()

        // act
        viewModel.binding.title = ""

        // assert
        XCTAssertEqual(viewModel.output.titleValidation, .empty)
    }

    func test_binding_title_21文字以上の場合にoutput_titleValidationがlongを出力すること() {
        // arrange
        setupViewModel()

        // act
        viewModel.binding.title = String(repeating: "a", count: 21)

        // assert
        XCTAssertEqual(viewModel.output.titleValidation, .long)
    }

    func test_binding_body_1文字以上20文字以下の場合にoutput_bodyValidationがnoneを出力すること() {
        // arrange
        setupViewModel()

        // act
        viewModel.binding.body = String(repeating: "a", count: 10)

        // assert
        XCTAssertEqual(viewModel.output.bodyValidation, ValidationError.none)
    }

    func test_binding_body_空文字の場合にoutput_bodyValidationがemptyを出力すること() {
        // arrange
        setupViewModel()

        // act
        viewModel.binding.body = ""

        // assert
        XCTAssertEqual(viewModel.output.bodyValidation, .empty)
    }

    func test_binding_body_21文字以上の場合にoutput_bodyValidationがlongを出力すること() {
        // arrange
        setupViewModel()

        // act
        viewModel.binding.body = String(repeating: "a", count: 21)

        // assert
        XCTAssertEqual(viewModel.output.bodyValidation, .long)
    }

    func test_有効_登録ボタンをタップした際に入力情報を登録できること() throws {
        // arrange
        setupViewModel()

        viewModel.binding.title = String(repeating: "a", count: 15)
        viewModel.binding.body = String(repeating: "b", count: 15)

        // act
        viewModel.input.addButtonTapped.send(())

        let publisher = viewModel.output.$modelObject.collect(1).first()
        let output = try awaitOutputPublisher(publisher)

        // assert
        XCTAssertEqual(
            output.first,
            SampleModelObjectBuilder().build()
        )
    }

    func test_無効_登録ボタンをタップした際にエラー情報を取得できること() throws {
        // arrange
        setupViewModel(isSuccess: false)

        viewModel.binding.title = String(repeating: "a", count: 15)
        viewModel.binding.body = String(repeating: "b", count: 15)

        // act
        viewModel.input.addButtonTapped.send(())

        let publisher = viewModel.output.$appError.collect(1).first()
        let output = try awaitOutputPublisher(publisher)

        // assert
        XCTAssertEqual(
            output.first,
            .init(error: .invalidStatusCode(400))
        )
    }
}

private extension SampleAddViewModelTest {
    func setupViewModel(isSuccess: Bool = true) {
        model = .init()
        analytics = .init(screenId: .sampleAdd)

        if isSuccess {
            model.postHandler = { _ in
                Future<SampleModelObject, AppError> { promise in
                    promise(.success(SampleModelObjectBuilder().build()))
                }
                .eraseToAnyPublisher()
            }
        } else {
            model.postHandler = { _ in
                Future<SampleModelObject, AppError> { promise in
                    promise(.failure(.init(error: .invalidStatusCode(400))))
                }
                .eraseToAnyPublisher()
            }
        }

        viewModel = .init(
            model: model,
            analytics: analytics
        )
    }
}
