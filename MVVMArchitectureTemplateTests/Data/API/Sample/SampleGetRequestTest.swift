@testable import MVVMArchitectureTemplate
import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

final class SampleGetRequestTest: XCTestCase {
    override func tearDown() {
        super.tearDown()

        HTTPStubs.removeAllStubs()
    }

    func test_get_成功_正常系のレスポンスを取得できること() {
        // arrange
        let expectation = XCTestExpectation(description: "通信待機")

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
        APIClient().request(
            item: SampleGetRequest(parameters: .init(userId: nil))
        ) { result in
            switch result {
            case let .success(dataObject):
                // assert
                XCTAssertNotNil(dataObject)
                XCTAssertEqual(dataObject.count, 100)
                XCTAssertEqual(dataObject.first!.userId, 1)

            case let .failure(error):
                XCTFail(error.localizedDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func test_get_失敗_異常系のエラーを取得できること() {
        // arrange
        let expectation = XCTestExpectation(description: "通信待機")

        stub(condition: isPath("/posts")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "failure_sample_get.json",
                    type(of: self)
                )!,
                headers: ["Content-Type": "application/json"]
            )
        }

        // act
        APIClient().request(
            item: SampleGetRequest(parameters: .init(userId: nil))
        ) { result in
            switch result {
            case .success:
                XCTFail()

            case let .failure(error):
                // assert
                XCTAssertEqual(error, .decodeError)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func test_get_失敗_エラーコードを取得できること() {
        // arrange
        let expectation = XCTestExpectation(description: "通信待機")

        stub(condition: isPath("/posts")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "success_sample_get.json",
                    type(of: self)
                )!,
                status: 400,
                headers: ["Content-Type": "application/json"]
            )
        }

        // act
        APIClient().request(
            item: SampleGetRequest(parameters: .init(userId: nil))
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
