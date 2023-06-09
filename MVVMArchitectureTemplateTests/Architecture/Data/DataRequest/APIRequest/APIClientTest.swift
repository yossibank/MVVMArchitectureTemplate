@testable import MVVMArchitectureTemplate
import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

final class APIClientTest: XCTestCase {
    private var apiClient: APIClient!
    private var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()

        apiClient = .init()
        expectation = .init(description: #function)
    }

    override func tearDown() {
        super.tearDown()

        HTTPStubs.removeAllStubs()
    }

    func test_受け取ったステータスコードが300台の際にステータスコードエラーを受け取れること() async throws {
        // arrange
        stub(condition: isPath("/posts")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "success_sample_get.json",
                    type(of: self)
                )!,
                status: 302,
                headers: ["Content-Type": "application/json"]
            )
        }

        do {
            // act
            _ = try await apiClient.request(
                item: SampleGetRequest(parameters: .init(userId: nil))
            )
        } catch {
            // assert
            XCTAssertEqual(
                APIError.parse(error),
                .invalidStatusCode(302)
            )
        }
    }

    func test_受け取ったステータスコードが400台の際にステータスコードエラーを受け取れること() async throws {
        // arrange
        stub(condition: isPath("/posts")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "success_sample_get.json",
                    type(of: self)
                )!,
                status: 404,
                headers: ["Content-Type": "application/json"]
            )
        }

        do {
            // act
            _ = try await apiClient.request(
                item: SampleGetRequest(parameters: .init(userId: nil))
            )
        } catch {
            // assert
            XCTAssertEqual(
                APIError.parse(error),
                .invalidStatusCode(404)
            )
        }
    }

    func test_受け取ったステータスコードが500台の際にステータスコードエラーを受け取れること() async throws {
        // arrange
        stub(condition: isPath("/posts")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "success_sample_get.json",
                    type(of: self)
                )!,
                status: 500,
                headers: ["Content-Type": "application/json"]
            )
        }

        do {
            // act
            _ = try await apiClient.request(
                item: SampleGetRequest(parameters: .init(userId: nil))
            )
        } catch {
            // assert
            XCTAssertEqual(
                APIError.parse(error),
                .invalidStatusCode(500)
            )
        }
    }
}
