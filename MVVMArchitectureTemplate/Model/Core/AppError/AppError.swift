import Foundation

struct AppError: Error, Equatable {
    private let apiError: APIError

    init(apiError: APIError) {
        self.apiError = apiError
    }
}

extension AppError {
    static func parse(_ error: Error) -> AppError {
        guard let appError = error as? AppError else {
            return .init(apiError: .unknown)
        }

        return appError
    }
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        apiError.errorDescription
    }
}
