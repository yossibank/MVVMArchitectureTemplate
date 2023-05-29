import Foundation

struct SamplePutRequest: Request {
    typealias Response = SampleDataObject

    struct Parameters: Codable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }

    var method: HTTPMethod { .put }
    var path: String { "/posts/\(id)" }

    let parameters: Parameters

    private let id: Int

    init(
        parameters: Parameters,
        pathComponent id: Int
    ) {
        self.parameters = parameters
        self.id = id
    }
}
