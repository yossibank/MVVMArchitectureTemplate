import SwiftUI

@MainActor
struct SampleDetailScreenRequest {
    let modelObject: SampleModelObject
}

extension SampleDetailScreenRequest: ScreenRequestProtocol {
    typealias ViewController = SampleDetailViewController
}
