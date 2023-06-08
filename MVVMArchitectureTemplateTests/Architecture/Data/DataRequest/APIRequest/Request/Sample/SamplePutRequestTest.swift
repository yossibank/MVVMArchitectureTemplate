@testable import MVVMArchitectureTemplate
import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

final class SamplePutRequestTest: XCTestCase {
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

    func test_put_成功_正常系のレスポンスを取得できること() async {
        // arrange
        stub(condition: isPath("/posts/1")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "success_sample_put.json",
                    type(of: self)
                )!,
                headers: ["Content-Type": "application/json"]
            )
        }

        // act
        let dataObject = try! await apiClient.request(
            item: SamplePutRequest(
                parameters: .init(
                    userId: 1,
                    id: 1,
                    title: "sample title",
                    body: "sample body"
                ),
                pathComponent: 1
            )
        )

        // assert
        XCTAssertEqual(
            dataObject,
            SampleDataObjectBuilder().build()
        )
    }

    func test_put_デコード失敗_エラーを取得できること() async throws {
        // arrange
        stub(condition: isPath("/posts/1")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "failure_sample_put.json",
                    type(of: self)
                )!,
                headers: ["Content-Type": "application/json"]
            )
        }

        do {
            _ = try await apiClient.request(
                item: SamplePutRequest(
                    parameters: .init(
                        userId: 1,
                        id: 1,
                        title: "sample title",
                        body: "sample body"
                    ),
                    pathComponent: 1
                )
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
