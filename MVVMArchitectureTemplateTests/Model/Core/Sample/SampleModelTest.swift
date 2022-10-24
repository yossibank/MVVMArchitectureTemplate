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
        model = .init(apiClient: apiClient)
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
        let publisher = model.get(converter: converter)
        let result = try awaitOutputPublisher(publisher)
        let expectation = [SampleModelObjectBuilder().build()]

        // assert
        XCTAssertEqual(result, expectation)
    }

    func test_get_失敗_エラーを取得できること() throws {
        // arrange
        apiClient.requestHandler = { _, completion in
            if let completion = completion as? (Result<[SampleDataObject], APIError>) -> Void {
                completion(.failure(.urlSessionError))
            }
        }

        // act
        let publisher = model.get(converter: converter)
        let result = try awaitResultPublisher(publisher)
        let expectation = APIError.urlSessionError

        switch result {
        case .success:
            XCTFail()

        case let .failure(error):
            // assert
            XCTAssertEqual(error as! APIError, expectation)
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
        let publisher = model.post(parameters: parameters, converter: converter)
        let result = try awaitOutputPublisher(publisher)
        let expectation = SampleModelObjectBuilder().build()

        // assert
        XCTAssertEqual(result, expectation)
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
        let publisher = model.post(parameters: parameters, converter: converter)
        let result = try awaitResultPublisher(publisher)
        let expectation = APIError.invalidStatusCode(400)

        switch result {
        case .success:
            XCTFail()

        case let .failure(error):
            // assert
            XCTAssertEqual(error as! APIError, expectation)
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
        let publisher = model.put(userId: 1, parameters: parameters, converter: converter)
        let result = try awaitOutputPublisher(publisher)
        let expectation = SampleModelObjectBuilder().build()

        // assert
        XCTAssertEqual(result, expectation)
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
        let publisher = model.put(userId: 1, parameters: parameters, converter: converter)
        let result = try awaitResultPublisher(publisher)
        let expectation = APIError.emptyResponse

        switch result {
        case .success:
            XCTFail()

        case let .failure(error):
            // assert
            XCTAssertEqual(error as! APIError, expectation)
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
        let result = try awaitOutputPublisher(publisher)
        let expectation = true

        // assert
        XCTAssertEqual(result, expectation)
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
        let expectation = APIError.invalidRequest

        switch result {
        case .success:
            XCTFail()

        case let .failure(error):
            // assert
            XCTAssertEqual(error as! APIError, expectation)
        }
    }
}
