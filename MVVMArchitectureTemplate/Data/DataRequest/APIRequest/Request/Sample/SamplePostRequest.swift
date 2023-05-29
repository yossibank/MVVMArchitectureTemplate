import Foundation

struct SamplePostRequest: Request {
    typealias Response = SampleDataObject
    typealias PathComponent = EmptyPathComponent

    struct Parameters: Codable {
        let userId: Int
        let title: String
        let body: String
    }

    var method: HTTPMethod { .post }
    var path: String { "/posts" }

    let parameters: Parameters

    init(
        parameters: Parameters,
        pathComponent: PathComponent = .init()
    ) {
        self.parameters = parameters
    }
}
