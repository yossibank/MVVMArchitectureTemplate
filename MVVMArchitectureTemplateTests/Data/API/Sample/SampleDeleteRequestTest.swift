@testable import MVVMArchitectureTemplate
import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

final class SampleDeleteRequestTest: XCTestCase {
    override func tearDown() {
        super.tearDown()

        HTTPStubs.removeAllStubs()
    }

    func test_delete_成功_正常系のレスポンスを取得できること() {
        // arrange
        let expectation = XCTestExpectation(description: "通信待機")

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
        APIClient().request(
            item: SampleDeleteRequest(pathComponent: 1)
        ) { result in
            switch result {
            case let .success(dataObject):
                // assert
                XCTAssertNotNil(dataObject)

            case let .failure(error):
                XCTFail(error.localizedDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func test_delete_失敗_エラーコードを取得できること() {
        // arrange
        let expectation = XCTestExpectation(description: "通信待機")

        stub(condition: isPath("/posts/1")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "success_sample_delete.json",
                    type(of: self)
                )!,
                status: 400,
                headers: ["Content-Type": "application/json"]
            )
        }

        // act
        APIClient().request(
            item: SampleDeleteRequest(pathComponent: 1)
        ) { result in
            switch result {
            case .success:
                XCTFail()

            case let .failure(error):
                // assert
                XCTAssertEqual(error, .invalidStatusCode(400))
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)
    }
}
