@testable import MVVMArchitectureTemplate
import XCTest

final class AppErrorTest: XCTestCase {
    func test_parse_不明エラーを受け取った際にunknownを返却できること() {
        // arrange
        let error = NSError(
            domain: "error",
            code: -999
        )

        // act
        let appError = AppError.parse(error)

        // assert
        XCTAssertEqual(
            appError,
            .init(apiError: .unknown)
        )
    }

    func test_parse_appErrorを受け取った際にappErrorを返却できること() {
        // arrange
        let error = AppError(apiError: .emptyResponse)

        // act
        let appError = AppError.parse(error)

        // assert
        XCTAssertEqual(
            appError,
            .init(apiError: .emptyResponse)
        )
    }

    func test_errorDescription_適切な文言を返却できること() {
        // assert
        XCTAssertEqual(
            AppError(apiError: .emptyData).errorDescription,
            "データエラー"
        )

        XCTAssertEqual(
            AppError(apiError: .emptyResponse).errorDescription,
            "レスポンスエラー"
        )

        XCTAssertEqual(
            AppError(apiError: .invalidRequest).errorDescription,
            "無効リクエスト"
        )

        XCTAssertEqual(
            AppError(apiError: .invalidStatusCode(400)).errorDescription,
            "無効ステータスコード【400】"
        )

        XCTAssertEqual(
            AppError(apiError: .offline).errorDescription,
            "ネットワークエラー"
        )

        XCTAssertEqual(
            AppError(apiError: .decode).errorDescription,
            "デコードエラー"
        )

        XCTAssertEqual(
            AppError(apiError: .unknown).errorDescription,
            "不明エラー"
        )
    }
}
