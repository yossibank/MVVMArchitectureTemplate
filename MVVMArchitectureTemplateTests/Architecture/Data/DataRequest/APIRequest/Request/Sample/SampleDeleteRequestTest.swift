@testable import MVVMArchitectureTemplate
import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

final class SampleDeleteRequestTest: XCTestCase {
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

    func test_delete_成功_正常系のレスポンスを取得できること() async {
        // arrange
        stub(condition: isPath("/posts/1")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "success_sample_delete.json",
                    type(of: self)
                )!,
                headers: ["Content-Type": "application/json"]
            )
        }

        // act
        let dataObject = try! await apiClient.request(
            item: SampleDeleteRequest(pathComponent: 1)
        )

        // assert
        XCTAssertNotNil(dataObject)
    }
}
