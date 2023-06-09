import Foundation

enum APIError: Error, Equatable {
    case emptyData
    case emptyResponse
    case invalidRequest
    case invalidStatusCode(Int)
    case offline
    case decode
    case unknown
}

extension APIError {
    static func parse(_ error: Error) -> APIError {
        guard error as? DecodingError == nil else {
            return .decode
        }

        guard error._code != -1009 else {
            return .offline
        }

        guard let apiError = error as? APIError else {
            return .unknown
        }

        return apiError
    }
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyData:
            return "データエラー"

        case .emptyResponse:
            return "レスポンスエラー"

        case .invalidRequest:
            return "無効リクエスト"

        case let .invalidStatusCode(code):
            return "無効ステータスコード【\(code.description)】"

        case .offline:
            return "ネットワークエラー"

        case .decode:
            return "デコードエラー"

        case .unknown:
            return "不明エラー"
        }
    }
}
