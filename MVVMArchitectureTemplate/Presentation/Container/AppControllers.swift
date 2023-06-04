import SwiftUI

enum AppControllers {
    enum Sample {
        static func Edit(_ modelObject: SampleModelObject) -> SampleEditViewController {
            let vc = SampleEditViewController()

            vc.title = "サンプル編集"
            vc.inject(
                contentView: .init(modelObject: modelObject),
                viewModel: .init(
                    model: Models.Sample(),
                    modelObject: modelObject,
                    analytics: FirebaseAnalytics(screenId: .sampleEdit)
                )
            )

            return vc
        }
    }
}
