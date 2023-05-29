import Foundation

struct SampleGetRequest: Request {
    typealias Response = [SampleDataObject]
    typealias PathComponent = EmptyPathComponent

    struct Parameters: Codable {
        let userId: Int?
    }

    var method: HTTPMethod { .get }
    var path: String { "/posts" }

    let parameters: Parameters

    init(
        parameters: Parameters,
        pathComponent: PathComponent = .init()
    ) {
        self.parameters = parameters
    }
}
