import Combine

/// @mockable
protocol SampleModelInput: Sendable {
    func get(userId: Int?) async throws -> [SampleModelObject]
    func post(parameters: SamplePostRequest.Parameters) async throws -> SampleModelObject
    func put(userId: Int, parameters: SamplePutRequest.Parameters) async throws -> SampleModelObject
    func delete(userId: Int) async throws -> Bool
}

struct SampleModel: SampleModelInput {
    private let apiClient: APIClientInput
    private let sampleConverter: SampleConverterInput
    private let errorConverter: AppErrorConverterInput

    init(
        apiClient: APIClientInput,
        sampleConverter: SampleConverterInput,
        errorConverter: AppErrorConverterInput
    ) {
        self.apiClient = apiClient
        self.sampleConverter = sampleConverter
        self.errorConverter = errorConverter
    }

    func get(userId: Int? = nil) async throws -> [SampleModelObject] {
        do {
            let dataObject = try await apiClient.request(
                item: SampleGetRequest(
                    parameters: .init(userId: userId)
                )
            )
            let modelObject = sampleConverter.convert(dataObject)
            return modelObject
        } catch {
            let appError = errorConverter.convert(APIError.parse(error))
            throw appError
        }
    }

    func post(parameters: SamplePostRequest.Parameters) async throws -> SampleModelObject {
        do {
            let dataObject = try await apiClient.request(
                item: SamplePostRequest(parameters: parameters)
            )
            let modelObject = sampleConverter.convert(dataObject)
            return modelObject
        } catch {
            let appError = errorConverter.convert(APIError.parse(error))
            throw appError
        }
    }

    func put(
        userId: Int,
        parameters: SamplePutRequest.Parameters
    ) async throws -> SampleModelObject {
        do {
            let dataObject = try await apiClient.request(
                item: SamplePutRequest(
                    parameters: parameters,
                    pathComponent: userId
                )
            )
            let modelObject = sampleConverter.convert(dataObject)
            return modelObject
        } catch {
            let appError = errorConverter.convert(APIError.parse(error))
            throw appError
        }
    }

    func delete(userId: Int) async throws -> Bool {
        do {
            _ = try await apiClient.request(
                item: SampleDeleteRequest(pathComponent: userId)
            )
            return true
        } catch {
            let appError = errorConverter.convert(APIError.parse(error))
            throw appError
        }
    }
}
