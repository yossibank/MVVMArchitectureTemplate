/// @mockable
protocol AppErrorConverterInput {
    func convert(_ apiError: APIError) -> AppError
}

struct AppErrorConverter: AppErrorConverterInput {
    func convert(_ apiError: APIError) -> AppError {
        .init(apiError: apiError)
    }
}
