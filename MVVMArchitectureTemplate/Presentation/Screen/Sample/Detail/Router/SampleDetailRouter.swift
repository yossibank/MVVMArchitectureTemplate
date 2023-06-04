import SwiftUI

/// @mockable
protocol SampleDetailRouterInput {
    func routeToEdit() -> Text
}

final class SampleDetailRouter: SampleDetailRouterInput {
    func routeToEdit() -> Text {
        Text("Edit")
    }
}
