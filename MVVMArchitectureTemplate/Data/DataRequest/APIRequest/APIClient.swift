import Foundation

/// @mockable
protocol APIClientInput: Sendable {
    func request<T>(item: some Request<T>) async throws -> T
}

struct APIClient: APIClientInput {
    func request<T>(item: some Request<T>) async throws -> T {
        guard let urlRequest = createURLRequest(item) else {
            throw APIError.invalidRequest
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard !data.isEmpty else {
                throw APIError.emptyData
            }

            guard let response = response as? HTTPURLResponse else {
                throw APIError.emptyResponse
            }

            guard (200 ... 299).contains(response.statusCode) else {
                throw APIError.invalidStatusCode(response.statusCode)
            }

            let decoder: JSONDecoder = {
                $0.keyDecodingStrategy = .convertFromSnakeCase
                return $0
            }(JSONDecoder())

            let value = try decoder.decode(
                T.self,
                from: data
            )

            return value
        } catch {
            throw APIError.parse(error)
        }
    }
}

private extension APIClient {
    func createURLRequest(_ requestItem: some Request) -> URLRequest? {
        guard let fullPath = URL(string: requestItem.baseURL + requestItem.path) else {
            return nil
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = fullPath.scheme
        urlComponents.host = fullPath.host
        urlComponents.path = fullPath.path
        urlComponents.port = fullPath.port
        urlComponents.queryItems = requestItem.queryItems

        guard let url = urlComponents.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = requestItem.timeoutInterval
        urlRequest.httpMethod = requestItem.method.rawValue
        urlRequest.httpBody = requestItem.body

        requestItem.headers.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }

        Logger.debug(message: urlRequest.curlString)

        return urlRequest
    }
}
