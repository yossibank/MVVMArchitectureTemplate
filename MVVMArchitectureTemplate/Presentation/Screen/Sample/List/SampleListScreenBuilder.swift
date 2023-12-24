import SwiftUI

@MainActor
struct SampleListScreenBuilder: ScreenBuilderProtocol {
    private let model: SampleModelInput
    private let analytics: FirebaseAnalyzable
    private let routerService: RouterServiceProtocol

    init(
        model: SampleModelInput,
        analytics: FirebaseAnalyzable,
        routerService: RouterServiceProtocol
    ) {
        self.model = model
        self.analytics = analytics
        self.routerService = routerService
    }

    func buildViewController(
        request: SampleListScreenRequest
    ) -> SampleListScreenRequest.ViewController {
        let viewModel = SampleListViewModel(
            state: .init(),
            dependency: .init(
                model: model,
                analytics: analytics
            )
        )

        let vc = SampleListViewController(
            rootView: SampleListScreenView(viewModel: viewModel),
            viewModel: viewModel,
            routerService: routerService
        )

        return vc
    }
}
