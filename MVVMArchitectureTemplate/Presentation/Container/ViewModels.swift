import Foundation

enum ViewModels {
    @MainActor
    enum Sample {
        static func Edit(modelObject: SampleModelObject) -> SampleEditViewModel {
            .init(
                modelObject: modelObject,
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleEdit)
            )
        }
    }
}
