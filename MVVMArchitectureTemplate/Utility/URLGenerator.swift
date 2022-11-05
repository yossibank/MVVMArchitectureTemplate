import Foundation

/// @mockable
protocol URLGeneratable {
    var urlType: URLType { get }

    func url() -> URL?
    func queryUrl(queryItems: [URLQueryItem]) -> URL?
}

enum URLType {
    case url(URL?)
    case urlString(String)
}

struct URLGenerator: URLGeneratable {
    var urlType: URLType

    func url() -> URL? {
        switch urlType {
        case let .url(url):
            return url

        case let .urlString(string):
            return URL(string: string)
        }
    }

    func queryUrl(queryItems: [URLQueryItem]) -> URL? {
        guard let url = url() else {
            return nil
        }

        var urlComponent = URLComponents(
            url: url,
            resolvingAgainstBaseURL: true
        )

        urlComponent?.queryItems = queryItems

        return urlComponent?.url
    }
}
