import Combine
@testable import MVVMArchitectureTemplate
import XCTest

final class SampleAddViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var viewModel: SampleAddViewModel!

    func test_binding_title_15文字以下の場合にoutput_isEnabledTitleがtrueを出力すること() {
        // arrange
        setupViewModel()

        // act
        viewModel.binding.title = String(repeating: "a", count: 15)

        // assert
        XCTAssertTrue(viewModel.output.isEnabledTitle)
    }

    func test_binding_title_16文字以上の場合にoutput_isEnabledTitleがfalseを出力すること() {
        // arrange
        setupViewModel()

        // act
        viewModel.binding.title = String(repeating: "a", count: 16)

        // assert
        XCTAssertFalse(viewModel.output.isEnabledTitle)
    }

    func test_binding_body_30文字以下の場合にoutput_isEnabledBodyがtrueを出力すること() {
        // arrange
        setupViewModel()

        // act
        viewModel.binding.body = String(repeating: "a", count: 30)

        // assert
        XCTAssertTrue(viewModel.output.isEnabledBody)
    }

    func test_binding_body_31文字以上の場合にoutput_isEnabledBodyがfalseを出力すること() {
        // arrange
        setupViewModel()

        // act
        viewModel.binding.body = String(repeating: "a", count: 31)

        // assert
        XCTAssertFalse(viewModel.output.isEnabledBody)
    }

    func test_有効_登録ボタンをタップした際に入力情報を登録できること() {
        // arrange
        let expectation = XCTestExpectation(description: #function)

        setupViewModel()

        viewModel.binding.title = String(repeating: "a", count: 10)
        viewModel.binding.body = String(repeating: "b", count: 20)

        // act
        viewModel.input.addButtonTapped.send(())

        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.output.modelObject, SampleModelObjectBuilder().build())
            XCTAssertEqual(self.viewModel.binding.isCompleted, true)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.5)
    }

    func test_無効_登録ボタンをタップした際にエラー情報を登録できること() {
        // arrange
        let expectation = XCTestExpectation(description: #function)

        setupViewModel(isSuccess: false)

        viewModel.binding.title = String(repeating: "a", count: 10)
        viewModel.binding.body = String(repeating: "b", count: 20)

        // act
        viewModel.input.addButtonTapped.send(())

        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.output.appError, .init(error: .invalidStatusCode(400)))
            XCTAssertEqual(self.viewModel.binding.isCompleted, true)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.5)
    }
}

private extension SampleAddViewModelTest {
    func setupViewModel(isSuccess: Bool = true) {
        model = .init()

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

        viewModel = .init(model: model)
    }
}
