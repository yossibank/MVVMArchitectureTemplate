import SwiftUI

/// @mockable
protocol SampleDetailRouterInput {
    func routeToEdit(modelObject: SampleModelObject) -> NavigationView<SampleEditView>
}

final class SampleDetailRouter: SampleDetailRouterInput {
    func routeToEdit(modelObject: SampleModelObject) -> NavigationView<SampleEditView> {
        NavigationView {
            SampleEditView(modelObject: modelObject)
        }
    }
}
