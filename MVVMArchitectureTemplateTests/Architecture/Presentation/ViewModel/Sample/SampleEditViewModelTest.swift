import Combine
@testable import MVVMArchitectureTemplate
import XCTest

final class SampleEditViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleEditViewModel!

    func test_viewWillAppear_FA_screenViewイベントを送信できていること() {
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

    func test_受け取ったModelObjectがBindingに入力されていること() {
        // arrange
        setupViewModel()

        // assert
        XCTAssertEqual(
            viewModel.binding.title,
            "sample title"
        )

        XCTAssertEqual(
            viewModel.binding.body,
            "sample body"
        )
    }

    func test_有効_編集ボタンをタップした際に入力情報を更新できること() {
        // arrange
        let expectation = XCTestExpectation(description: #function)

        setupViewModel()

        // act
        viewModel.input.editButtonTapped.send(())

        DispatchQueue.main.async {
            // assert
            XCTAssertEqual(
                self.viewModel.output.modelObject,
                SampleModelObjectBuilder()
                    .title("sample edit title")
                    .body("sample edit body")
                    .build()
            )

            XCTAssertEqual(
                self.viewModel.binding.isCompleted,
                true
            )

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.5)
    }

    func test_無効_編集ボタンをタップした際にエラー情報を取得できること() {
        // arrange
        let expectation = XCTestExpectation(description: #function)

        setupViewModel(isSuccess: false)

        // act
        viewModel.input.editButtonTapped.send(())

        DispatchQueue.main.async {
            XCTAssertEqual(
                self.viewModel.output.appError,
                .init(error: .invalidStatusCode(400))
            )

            XCTAssertEqual(
                self.viewModel.binding.isCompleted,
                true
            )

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.5)
    }
}

private extension SampleEditViewModelTest {
    func setupViewModel(isSuccess: Bool = true) {
        model = .init()
        analytics = .init(screenId: .sampleEdit)

        if isSuccess {
            model.putHandler = { _, _ in
                Future<SampleModelObject, AppError> { promise in
                    promise(
                        .success(
                            SampleModelObjectBuilder()
                                .title("sample edit title")
                                .body("sample edit body")
                                .build()
                        )
                    )
                }
                .eraseToAnyPublisher()
            }
        } else {
            model.putHandler = { _, _ in
                Future<SampleModelObject, AppError> { promise in
                    promise(.failure(.init(error: .invalidStatusCode(400))))
                }
                .eraseToAnyPublisher()
            }
        }

        viewModel = .init(
            model: model,
            modelObject: SampleModelObjectBuilder().build(),
            analytics: analytics
        )
    }
}