import SwiftUI

@MainActor
struct SampleAddScreenBuilder: ScreenBuilderProtocol {
    private let model: SampleModelInput
    private let analytics: FirebaseAnalyzable

    init(
        model: SampleModelInput,
        analytics: FirebaseAnalyzable
    ) {
        self.model = model
        self.analytics = analytics
    }

    func buildViewController(
        request: SampleAddScreenRequest
    ) -> SampleAddScreenRequest.ViewController {
        let viewModel = SampleAddViewModel(
            state: .init(),
            dependency: .init(
                model: model,
                analytics: analytics
            )
        )

        let vc = SampleAddViewController(
            rootView: SampleAddScreenView(viewModel: viewModel),
            viewModel: viewModel
        )

        return vc
    }
}
