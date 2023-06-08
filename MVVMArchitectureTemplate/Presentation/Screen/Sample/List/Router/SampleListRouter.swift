import SwiftUI

/// @mockable
protocol SampleListRouterInput {
    func routeToAdd(viewModel: SampleAddViewModel) -> SampleAddView
    func routeToDetail(modelObject: SampleModelObject) -> SampleDetailView
}

final class SampleListRouter: SampleListRouterInput {
    func routeToAdd(viewModel: SampleAddViewModel) -> SampleAddView {
        SampleAddView(viewModel: viewModel)
    }

    func routeToDetail(modelObject: SampleModelObject) -> SampleDetailView {
        SampleDetailView(modelObject: modelObject)
    }
}
