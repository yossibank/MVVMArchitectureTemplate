#if DEBUG
    final class AppErrorBuilder {
        private var apiError: APIError = .unknown

        func build() -> AppError {
            .init(apiError: apiError)
        }

        func error(_ apiError: APIError) -> Self {
            self.apiError = apiError
            return self
        }
    }
#endif
