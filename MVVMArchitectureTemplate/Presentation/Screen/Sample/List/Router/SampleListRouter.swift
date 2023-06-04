import SwiftUI

/// @mockable
protocol SampleListRouterInput {
    func routeToAdd() -> SampleAddView
    func routeToDetail(id: Int) -> Text
}

final class SampleListRouter: SampleListRouterInput {
    func routeToAdd() -> SampleAddView {
        SampleAddView()
    }

    func routeToDetail(id: Int) -> Text {
        Text("Detail: \(id)")
    }
}
