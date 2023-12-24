import SwiftUI

@MainActor
struct SampleEditScreenRequest {
    let modelObject: SampleModelObject
}

extension SampleEditScreenRequest: ScreenRequestProtocol {
    typealias ViewController = SampleEditViewController
}
