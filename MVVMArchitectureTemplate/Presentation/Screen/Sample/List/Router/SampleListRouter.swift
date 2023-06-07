import SwiftUI

/// @mockable
protocol SampleListRouterInput {
    func routeToAdd() -> SampleAddView
    func routeToDetail(modelObject: SampleModelObject) -> SampleDetailView
}

final class SampleListRouter: SampleListRouterInput {
    @MainActor
    func routeToAdd() -> SampleAddView {
        SampleAddView(viewModel: ViewModels.Sample.Add())
    }

    func routeToDetail(modelObject: SampleModelObject) -> SampleDetailView {
        SampleDetailView(modelObject: modelObject)
    }
}
