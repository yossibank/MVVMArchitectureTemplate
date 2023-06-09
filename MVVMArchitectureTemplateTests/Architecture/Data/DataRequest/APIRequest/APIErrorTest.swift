@testable import MVVMArchitectureTemplate
import XCTest

final class APIErrorTest: XCTestCase {
    func test_parse_decodingErrorを受け取った際にdecodeを返却できること() {
        // arrange
        let error = DecodingError.valueNotFound(
            String.self,
            .init(
                codingPath: [],
                debugDescription: "value not found"
            )
        )

        // act
        let apiError = APIError.parse(error)

        // assert
        XCTAssertEqual(
            apiError,
            .decode
        )
    }

    func test_parse_オフラインエラーを受け取った際にofflineを返却できること() {
        // arrange
        let error = NSError(
            domain: "error",
            code: -1009
        )

        // act
        let apiError = APIError.parse(error)

        // assert
        XCTAssertEqual(
            apiError,
            .offline
        )
    }

    func test_parse_不明エラーを受け取った際にunknownを返却できること() {
        // arrange
        let error = NSError(
            domain: "error",
            code: -999
        )

        // act
        let apiError = APIError.parse(error)

        // assert
        XCTAssertEqual(
            apiError,
            .unknown
        )
    }

    func test_parse_apiErrorを受け取った際にapiErrorを返却できること() {
        // arrange
        let error = APIError.invalidRequest

        // act
        let apiError = APIError.parse(error)

        // assert
        XCTAssertEqual(
            apiError,
            .invalidRequest
        )
    }

    func test_errorDescription_適切な文言を返却できること() {
        // assert
        XCTAssertEqual(
            APIError.emptyData.errorDescription,
            "データエラー"
        )

        XCTAssertEqual(
            APIError.emptyResponse.errorDescription,
            "レスポンスエラー"
        )

        XCTAssertEqual(
            APIError.invalidRequest.errorDescription,
            "無効リクエスト"
        )

        XCTAssertEqual(
            APIError.invalidStatusCode(400).errorDescription,
            "無効ステータスコード【400】"
        )

        XCTAssertEqual(
            APIError.offline.errorDescription,
            "ネットワークエラー"
        )

        XCTAssertEqual(
            APIError.decode.errorDescription,
            "デコードエラー"
        )

        XCTAssertEqual(
            APIError.unknown.errorDescription,
            "不明エラー"
        )
    }
}
