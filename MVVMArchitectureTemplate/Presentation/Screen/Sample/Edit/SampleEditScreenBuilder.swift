import SwiftUI

@MainActor
struct SampleEditScreenBuilder: ScreenBuilderProtocol {
    private let modelObject: SampleModelObject
    private let model: SampleModelInput
    private let analytics: FirebaseAnalyzable

    init(
        modelObject: SampleModelObject,
        model: SampleModelInput,
        analytics: FirebaseAnalyzable
    ) {
        self.modelObject = modelObject
        self.model = model
        self.analytics = analytics
    }

    func buildViewController(
        request: SampleEditScreenRequest
    ) -> SampleEditScreenRequest.ViewController {
        let viewModel = SampleEditViewModel(
            state: .init(modelObject: request.modelObject),
            dependency: .init(
                model: model,
                analytics: analytics
            )
        )

        let vc = SampleEditViewController(
            rootView: SampleEditScreenView(viewModel: viewModel),
            viewModel: viewModel
        )

        return vc
    }
}
