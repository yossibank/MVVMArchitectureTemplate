import SwiftUI

@MainActor
struct SampleDetailScreenBuilder: ScreenBuilderProtocol {
    private let modelObject: SampleModelObject
    private let analytics: FirebaseAnalyzable
    private let routerService: RouterServiceProtocol

    init(
        modelObject: SampleModelObject,
        analytics: FirebaseAnalyzable,
        routerService: RouterServiceProtocol
    ) {
        self.modelObject = modelObject
        self.analytics = analytics
        self.routerService = routerService
    }

    func buildViewController(
        request: SampleDetailScreenRequest
    ) -> SampleDetailScreenRequest.ViewController {
        let viewModel = SampleDetailViewModel(
            state: .init(modelObject: modelObject),
            dependency: .init(analytics: analytics)
        )

        let vc = SampleDetailViewController(
            rootView: SampleDetailScreenView(viewModel: viewModel),
            viewModel: viewModel,
            routerService: routerService
        )

        return vc
    }
}
