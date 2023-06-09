@testable import MVVMArchitectureTemplate
import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

final class SampleGetRequestTest: XCTestCase {
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

    func test_get_成功_正常系のレスポンスを取得できること() async {
        // arrange
        stub(condition: isPath("/posts")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "success_sample_get.json",
                    type(of: self)
                )!,
                headers: ["Content-Type": "application/json"]
            )
        }

        // act
        let dataObject = try! await apiClient.request(
            item: SampleGetRequest(parameters: .init(userId: nil))
        )

        // assert
        XCTAssertEqual(
            dataObject.count,
            100
        )

        XCTAssertEqual(
            dataObject.first!.userId,
            1
        )
    }

    func test_get_デコード失敗_エラーを取得できること() async throws {
        // arrange
        stub(condition: isPath("/posts")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "failure_sample_get.json",
                    type(of: self)
                )!,
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
                .decode
            )
        }
    }
}
