@testable import MVVMArchitectureTemplate
import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

final class SamplePostRequestTest: XCTestCase {
    private var apiClient: APIClient!

    override func setUp() {
        super.setUp()

        apiClient = .init()
    }

    override func tearDown() {
        super.tearDown()

        HTTPStubs.removeAllStubs()
    }

    func test_post_成功_正常系のレスポンスを取得できること() async {
        // arrange
        stub(condition: isPath("/posts")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "success_sample_post.json",
                    type(of: self)
                )!,
                headers: ["Content-Type": "application/json"]
            )
        }

        // act
        let dataObject = try! await apiClient.request(
            item: SamplePostRequest(parameters: .init(
                userId: 1,
                title: "sample title",
                body: "sample body"
            ))
        )

        // assert
        XCTAssertEqual(
            dataObject.userId,
            1
        )

        XCTAssertEqual(
            dataObject.title,
            "sample title"
        )

        XCTAssertEqual(
            dataObject.body,
            "sample body"
        )
    }

    func test_post_デコード失敗_エラーを取得できること() async throws {
        // arrange
        stub(condition: isPath("/posts")) { _ in
            fixture(
                filePath: OHPathForFile(
                    "failure_sample_post.json",
                    type(of: self)
                )!,
                headers: ["Content-Type": "application/json"]
            )
        }

        do {
            // act
            _ = try await apiClient.request(
                item: SamplePostRequest(parameters: .init(
                    userId: 1,
                    title: "sample title",
                    body: "sample body"
                ))
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
