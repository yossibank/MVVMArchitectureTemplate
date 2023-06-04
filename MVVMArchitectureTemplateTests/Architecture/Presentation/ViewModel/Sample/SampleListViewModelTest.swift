import Combine
@testable import MVVMArchitectureTemplate
import XCTest

final class SampleListViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var router: SampleListRouterInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleListViewModel!

    override func setUp() {
        super.setUp()

        model = .init()
        router = .init()
        analytics = .init(screenId: .sampleList)
        viewModel = .init(
            router: router,
            model: model,
            analytics: analytics
        )

        model.getHandler = { _ in
            Future<[SampleModelObject], AppError> { promise in
                promise(.success([SampleModelObjectBuilder().build()]))
            }
            .eraseToAnyPublisher()
        }

        viewModel.input.onAppear.send(())
    }

    func test_input_onAppear_一覧情報取得成功_一覧情報を取得できること() throws {
        // act
        let publisher = viewModel.output.$modelObjects.dropFirst().collect(1).first()
        let output = try awaitOutputPublisher(publisher).first

        // assert
        XCTAssertEqual(
            output,
            [SampleModelObjectBuilder().build()]
        )
    }

    func test_input_onAppear_一覧情報取得成功_エラー情報を取得できること() throws {
        // arrange
        model.getHandler = { _ in
            Future<[SampleModelObject], AppError> { promise in
                promise(.failure(.init(error: .invalidStatusCode(400))))
            }
            .eraseToAnyPublisher()
        }

        viewModel.input.onAppear.send(())

        // act
        let publisher = viewModel.output.$appError.dropFirst().collect(1).first()
        let output = try awaitOutputPublisher(publisher).first

        // assert
        XCTAssertEqual(
            output,
            .init(error: .invalidStatusCode(400))
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

    func test_output_placeholder_初期化時に値が代入されていること() throws {
        // act
        let publisher = viewModel.output.$placeholder.collect(1).first()
        let output = try awaitOutputPublisher(publisher).first!

        // assert
        XCTAssertEqual(output.count, 20)
    }
}
