import Combine
@testable import MVVMArchitectureTemplate
import XCTest

final class SampleListViewModelTest: XCTestCase {
    private var model: SampleModelInputMock!
    private var viewModel: SampleListViewModel!

    func test_画面表示_成功_一覧情報を取得できること() throws {
        // arrange
        setupViewModel()

        // act
        let publisher = viewModel.output.$modelObject.collect(1).first()
        let output = try awaitOutputPublisher(publisher)

        // assert
        XCTAssertEqual(
            output.first,
            [SampleModelObjectBuilder().build()]
        )
    }

    func test_画面表示_失敗_エラー情報を取得できること() throws {
        // arrange
        setupViewModel(isSuccess: false)

        // act
        let publisher = viewModel.output.$error.collect(1).first()
        let output = try awaitOutputPublisher(publisher)

        // assert
        XCTAssertEqual(
            output.first,
            .invalidStatusCode(400)
        )
    }
}

private extension SampleListViewModelTest {
    func setupViewModel(isSuccess: Bool = true) {
        model = .init()

        if isSuccess {
            model.getHandler = { _ in
                Future<[SampleModelObject], APIError> { promise in
                    promise(.success([SampleModelObjectBuilder().build()]))
                }
                .eraseToAnyPublisher()
            }
        } else {
            model.getHandler = { _ in
                Future<[SampleModelObject], APIError> { promise in
                    promise(.failure(.invalidStatusCode(400)))
                }
                .eraseToAnyPublisher()
            }
        }

        viewModel = .init(model: model)
    }
}
