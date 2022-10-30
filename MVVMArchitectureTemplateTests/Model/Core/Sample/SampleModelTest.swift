@testable import MVVMArchitectureTemplate
import XCTest

final class SampleModelTest: XCTestCase {
    private var apiClient: APIClientInputMock!
    private var converter: SampleConverterInputMock!
    private var model: SampleModel!

    override func setUp() {
        super.setUp()

        apiClient = .init()
        converter = .init()
        model = .init(apiClient: apiClient, converter: converter)
    }

    func test_get_成功_情報を取得できること() throws {
        // arrange
        apiClient.requestHandler = { _, completion in
            if let completion = completion as? (Result<[SampleDataObject], APIError>) -> Void {
                completion(.success([SampleDataObjectBuilder().build()]))
            }
        }

        converter.convertHandler = { _ in
            [SampleModelObjectBuilder().build()]
        }

        // act
        let publisher = model.get()
        let output = try awaitOutputPublisher(publisher)

        // assert
        XCTAssertEqual(
            output,
            [SampleModelObjectBuilder().build()]
        )
    }

    func test_get_失敗_エラーを取得できること() throws {
        // arrange
        apiClient.requestHandler = { _, completion in
            if let completion = completion as? (Result<[SampleDataObject], APIError>) -> Void {
                completion(.failure(.urlSessionError))
            }
        }

        // act
        let publisher = model.get()
        let result = try awaitResultPublisher(publisher)

        switch result {
        case .success:
            XCTFail()

        case let .failure(error):
            // assert
            XCTAssertEqual(
                error as! APIError,
                .urlSessionError
            )
        }
    }

    func test_post_成功_情報を取得できること() throws {
        // arrange
        apiClient.requestHandler = { _, completion in
            if let completion = completion as? (Result<SampleDataObject, APIError>) -> Void {
                completion(.success(SampleDataObjectBuilder().build()))
            }
        }

        converter.convertObjectHandler = { _ in
            SampleModelObjectBuilder().build()
        }

        // act
        let parameters = SamplePostRequest.Parameters(userId: 1, title: "title", body: "body")
        let publisher = model.post(parameters: parameters)
        let output = try awaitOutputPublisher(publisher)

        // assert
        XCTAssertEqual(
            output,
            SampleModelObjectBuilder().build()
        )
    }

    func test_post_失敗_エラーを取得できること() throws {
        // arrange
        apiClient.requestHandler = { _, completion in
            if let completion = completion as? (Result<SampleDataObject, APIError>) -> Void {
                completion(.failure(.invalidStatusCode(400)))
            }
        }

        converter.convertObjectHandler = { _ in
            SampleModelObjectBuilder().build()
        }

        // act
        let parameters = SamplePostRequest.Parameters(userId: 1, title: "title", body: "body")
        let publisher = model.post(parameters: parameters)
        let result = try awaitResultPublisher(publisher)

        switch result {
        case .success:
            XCTFail()

        case let .failure(error):
            // assert
            XCTAssertEqual(
                error as! APIError,
                .invalidStatusCode(400)
            )
        }
    }

    func test_put_成功_情報を取得できること() throws {
        // arrange
        apiClient.requestHandler = { _, completion in
            if let completion = completion as? (Result<SampleDataObject, APIError>) -> Void {
                completion(.success(SampleDataObjectBuilder().build()))
            }
        }

        converter.convertObjectHandler = { _ in
            SampleModelObjectBuilder().build()
        }

        // act
        let parameters = SamplePutRequest.Parameters(userId: 1, id: 1, title: "title", body: "body")
        let publisher = model.put(userId: 1, parameters: parameters)
        let output = try awaitOutputPublisher(publisher)

        // assert
        XCTAssertEqual(
            output,
            SampleModelObjectBuilder().build()
        )
    }

    func test_put_失敗_エラーを取得できること() throws {
        // arrange
        apiClient.requestHandler = { _, completion in
            if let completion = completion as? (Result<SampleDataObject, APIError>) -> Void {
                completion(.failure(.emptyResponse))
            }
        }

        converter.convertObjectHandler = { _ in
            SampleModelObjectBuilder().build()
        }

        // act
        let parameters = SamplePutRequest.Parameters(userId: 1, id: 1, title: "title", body: "body")
        let publisher = model.put(userId: 1, parameters: parameters)
        let result = try awaitResultPublisher(publisher)

        switch result {
        case .success:
            XCTFail()

        case let .failure(error):
            // assert
            XCTAssertEqual(
                error as! APIError,
                .emptyResponse
            )
        }
    }

    func test_delete_成功_情報を取得できること() throws {
        // arrange
        apiClient.requestHandler = { _, completion in
            if let completion = completion as? (Result<EmptyResponse, APIError>) -> Void {
                completion(.success(.init()))
            }
        }

        // act
        let publisher = model.delete(userId: 1)
        let output = try awaitOutputPublisher(publisher)

        // assert
        XCTAssertEqual(
            output,
            true
        )
    }

    func test_delete_失敗_エラーを取得できること() throws {
        // arrange
        apiClient.requestHandler = { _, completion in
            if let completion = completion as? (Result<EmptyResponse, APIError>) -> Void {
                completion(.failure(.invalidRequest))
            }
        }

        // act
        let publisher = model.delete(userId: 1)
        let result = try awaitResultPublisher(publisher)

        switch result {
        case .success:
            XCTFail()

        case let .failure(error):
            // assert
            XCTAssertEqual(
                error as! APIError,
                .invalidRequest
            )
        }
    }
}
