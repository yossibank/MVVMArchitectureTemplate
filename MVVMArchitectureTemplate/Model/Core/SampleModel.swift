import Combine

/// @mockable
protocol SampleModelInput: Model {
    func get(
        userId: Int?,
        converter: SampleConverterInput
    ) -> AnyPublisher<[SampleModelObject], APIError>

    func post(
        parameters: SamplePostRequest.Parameters,
        converter: SampleConverterInput
    ) -> AnyPublisher<SampleModelObject, APIError>

    func put(
        userId: Int,
        parameters: SamplePutRequest.Parameters,
        converter: SampleConverterInput
    ) -> AnyPublisher<SampleModelObject, APIError>

    func delete(
        userId: Int
    ) -> AnyPublisher<Bool, APIError>
}

struct SampleModel: SampleModelInput {
    private let apiClient: APIClientInput

    init(apiClient: APIClientInput) {
        self.apiClient = apiClient
    }

    func get(
        userId: Int? = nil,
        converter: SampleConverterInput
    ) -> AnyPublisher<[SampleModelObject], APIError> {
        toPublisher { promise in
            apiClient.request(
                item: SampleGetRequest(parameters: .init(userId: userId))
            ) {
                switch $0 {
                case let .success(dataObject):
                    let modelObject = converter.convert(dataObject)
                    promise(.success(modelObject))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func post(
        parameters: SamplePostRequest.Parameters,
        converter: SampleConverterInput
    ) -> AnyPublisher<SampleModelObject, APIError> {
        toPublisher { promise in
            apiClient.request(
                item: SamplePostRequest(parameters: parameters)
            ) {
                switch $0 {
                case let .success(dataObject):
                    let modelObject = converter.convert(dataObject)
                    promise(.success(modelObject))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func put(
        userId: Int,
        parameters: SamplePutRequest.Parameters,
        converter: SampleConverterInput
    ) -> AnyPublisher<SampleModelObject, APIError> {
        toPublisher { promise in
            apiClient.request(
                item: SamplePutRequest(
                    parameters: parameters,
                    pathComponent: userId
                )
            ) {
                switch $0 {
                case let .success(dataObject):
                    let modelObject = converter.convert(dataObject)
                    promise(.success(modelObject))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func delete(
        userId: Int
    ) -> AnyPublisher<Bool, APIError> {
        toPublisher { promise in
            apiClient.request(
                item: SampleDeleteRequest(pathComponent: userId)
            ) {
                switch $0 {
                case .success:
                    promise(.success(true))

                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}
