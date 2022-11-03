/// @mockable
protocol APIErrorConverterInput {
    func convert(_ error: APIError) -> AppError
}

struct APIErrorConverter: APIErrorConverterInput {
    func convert(_ error: APIError) -> AppError {
        .init(error: error)
    }
}
