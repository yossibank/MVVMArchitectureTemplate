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
        case .emptyData: "データエラー"
        case .emptyResponse: "レスポンスエラー"
        case .invalidRequest: "無効リクエスト"
        case let .invalidStatusCode(code): "無効ステータスコード【\(code.description)】"
        case .offline: "ネットワークエラー"
        case .decode: "デコードエラー"
        case .unknown: "不明エラー"
        }
    }
}
