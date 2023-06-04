import SwiftUI

/// @mockable
protocol SampleListRouterInput {
    func routeToAdd() -> SampleAddView
    func routeToDetail(modelObject: SampleModelObject) -> SampleDetailView
}

final class SampleListRouter: SampleListRouterInput {
    func routeToAdd() -> SampleAddView {
        SampleAddView()
    }

    func routeToDetail(modelObject: SampleModelObject) -> SampleDetailView {
        SampleDetailView(modelObject: modelObject)
    }
}
