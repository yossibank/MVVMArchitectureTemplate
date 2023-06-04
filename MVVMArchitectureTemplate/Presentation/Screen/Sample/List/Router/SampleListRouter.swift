import SwiftUI

/// @mockable
protocol SampleListRouterInput {
    func routeToAdd() -> Text
    func routeToDetail(id: Int) -> Text
}

final class SampleListRouter: SampleListRouterInput {
    func routeToAdd() -> Text {
        Text("Add")
    }

    func routeToDetail(id: Int) -> Text {
        Text("Detail: \(id)")
    }
}
