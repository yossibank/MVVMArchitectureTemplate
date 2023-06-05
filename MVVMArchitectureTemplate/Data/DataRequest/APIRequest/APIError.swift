enum APIError: Error, Equatable {
    case decodeError
    case urlSessionError
    case emptyData
    case emptyResponse
    case invalidRequest
    case invalidStatusCode(Int)
    case unknown

    static func parseError(_ error: Error) -> APIError {
        guard error as? DecodingError == nil else {
            return .decodeError
        }

        guard let apiError = error as? APIError else {
            return .unknown
        }

        return apiError
    }
}
