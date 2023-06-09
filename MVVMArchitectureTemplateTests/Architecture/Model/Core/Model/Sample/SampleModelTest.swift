@testable import MVVMArchitectureTemplate
import XCTest

final class SampleModelTest: XCTestCase {
    private var apiClient: APIClientInputMock!
    private var sampleConverter: SampleConverterInputMock!
    private var errorConverter: AppErrorConverterInputMock!
    private var model: SampleModel!

    override func setUp() {
        super.setUp()

        apiClient = .init()
        sampleConverter = .init()
        errorConverter = .init()
        model = .init(
            apiClient: apiClient,
            sampleConverter: sampleConverter,
            errorConverter: errorConverter
        )
    }

    func test_get_成功_情報を取得できること() async throws {
        // arrange
        apiClient.requestHandler = { request in
            // assert
            XCTAssertTrue(request is SampleGetRequest)

            return [SampleDataObjectBuilder().build()]
        }

        sampleConverter.convertHandler = { _ in
            [SampleModelObjectBuilder().build()]
        }

        // act
        let modelObject = try await model.get(userId: nil)

        // assert
        XCTAssertEqual(
            modelObject,
            [SampleModelObjectBuilder().build()]
        )
    }

    func test_get_失敗_エラーを取得できること() async throws {
        // arrange
        apiClient.requestHandler = { request in
            // assert
            XCTAssertTrue(request is SampleGetRequest)

            throw APIError.decode
        }

        errorConverter.convertHandler = { error in
            AppErrorBuilder()
                .error(error)
                .build()
        }

        do {
            // act
            _ = try await model.get(userId: nil)
        } catch {
            // assert
            XCTAssertEqual(
                AppError.parse(error),
                .init(apiError: .decode)
            )
        }
    }

    func test_post_成功_情報を取得できること() async throws {
        // arrange
        apiClient.requestHandler = { request in
            // assert
            XCTAssertTrue(request is SamplePostRequest)

            return SampleDataObjectBuilder().build()
        }

        sampleConverter.convertObjectHandler = { _ in
            SampleModelObjectBuilder().build()
        }

        // act
        let parameters = SamplePostRequest.Parameters(
            userId: 1,
            title: "title",
            body: "body"
        )

        let modelObject = try await model.post(parameters: parameters)

        // assert
        XCTAssertEqual(
            modelObject,
            SampleModelObjectBuilder().build()
        )
    }

    func test_post_失敗_エラーを取得できること() async throws {
        // arrange
        apiClient.requestHandler = { request in
            // assert
            XCTAssertTrue(request is SamplePostRequest)

            throw APIError.invalidStatusCode(400)
        }

        errorConverter.convertHandler = { error in
            AppErrorBuilder()
                .error(error)
                .build()
        }

        let parameters = SamplePostRequest.Parameters(
            userId: 1,
            title: "title",
            body: "body"
        )

        do {
            // act
            _ = try await model.post(parameters: parameters)
        } catch {
            // assert
            XCTAssertEqual(
                AppError.parse(error),
                .init(apiError: .invalidStatusCode(400))
            )
        }
    }

    func test_put_成功_情報を取得できること() async throws {
        // arrange
        apiClient.requestHandler = { request in
            // assert
            XCTAssertTrue(request is SamplePutRequest)

            return SampleDataObjectBuilder().build()
        }

        sampleConverter.convertObjectHandler = { _ in
            SampleModelObjectBuilder().build()
        }

        // act
        let parameters = SamplePutRequest.Parameters(
            userId: 1,
            id: 1,
            title: "title",
            body: "body"
        )

        let modelObject = try await model.put(
            userId: 1,
            parameters: parameters
        )

        // assert
        XCTAssertEqual(
            modelObject,
            SampleModelObjectBuilder().build()
        )
    }

    func test_put_失敗_エラーを取得できること() async throws {
        // arrange
        apiClient.requestHandler = { request in
            // assert
            XCTAssertTrue(request is SamplePutRequest)

            throw APIError.emptyResponse
        }

        errorConverter.convertHandler = { error in
            AppErrorBuilder()
                .error(error)
                .build()
        }

        let parameters = SamplePutRequest.Parameters(
            userId: 1,
            id: 1,
            title: "title",
            body: "body"
        )

        do {
            // act
            _ = try await model.put(
                userId: 1,
                parameters: parameters
            )
        } catch {
            // assert
            XCTAssertEqual(
                AppError.parse(error),
                .init(apiError: .emptyResponse)
            )
        }
    }

    func test_delete_成功_情報を取得できること() async throws {
        // arrange
        apiClient.requestHandler = { request in
            // assert
            XCTAssertTrue(request is SampleDeleteRequest)

            return EmptyResponse()
        }

        // act
        let bool = try await model.delete(userId: 1)

        // assert
        XCTAssertTrue(bool)
    }

    func test_delete_失敗_エラーを取得できること() async throws {
        // arrange
        apiClient.requestHandler = { request in
            // assert
            XCTAssertTrue(request is SampleDeleteRequest)

            throw APIError.invalidRequest
        }

        errorConverter.convertHandler = { error in
            AppErrorBuilder()
                .error(error)
                .build()
        }

        do {
            // act
            _ = try await model.delete(userId: 1)
        } catch {
            // assert
            XCTAssertEqual(
                AppError.parse(error),
                .init(apiError: .invalidRequest)
            )
        }
    }
}
