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

    func test_put_成功_正常系のレスポンスを取得できること() {
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
        apiClient.request(
            item: SamplePutRequest(
                parameters: .init(
                    userId: 1,
                    id: 1,
                    title: "sample title",
                    body: "sample body"
                ),
                pathComponent: 1
            )
        ) {
            switch $0 {
            case let .success(dataObject):
                // assert
                XCTAssertNotNil(dataObject)
                XCTAssertEqual(dataObject, SampleDataObjectBuilder().build())

            case let .failure(error):
                XCTFail(error.localizedDescription)
            }

            self.expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func test_put_デコード失敗_エラーを取得できること() {
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

        // act
        apiClient.request(
            item: SamplePutRequest(
                parameters: .init(
                    userId: 1,
                    id: 1,
                    title: "sample title",
                    body: "sample body"
                ),
                pathComponent: 1
            )
        ) {
            if case let .failure(error) = $0 {
                // assert
                XCTAssertEqual(
                    error,
                    .decode
                )

                self.expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }
}
