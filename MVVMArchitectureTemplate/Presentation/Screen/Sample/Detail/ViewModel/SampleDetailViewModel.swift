import SwiftUI

@MainActor
final class SampleDetailViewModel: ObservableObject {
    private(set) var modelObject: SampleModelObject

    private let router: SampleDetailRouterInput
    private let analytics: FirebaseAnalyzable

    init(
        modelObject: SampleModelObject,
        router: SampleDetailRouterInput,
        analytics: FirebaseAnalyzable
    ) {
        self.router = router
        self.modelObject = modelObject
        self.analytics = analytics

        // FAイベント
        analytics.sendEvent(.screenView)
    }
}

extension SampleDetailViewModel {
    func showEditView() -> NavigationView<SampleEditView> {
        router.routeToEdit(modelObject: modelObject)
    }
}
