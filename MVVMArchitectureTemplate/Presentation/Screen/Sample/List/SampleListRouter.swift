import SwiftUI

/// @mockable
protocol SampleListRouterInput {
    func routeToSample() -> Text
}

final class SampleListRouter: SampleListRouterInput {
    func routeToSample() -> Text {
        Text("sample")
    }
}
