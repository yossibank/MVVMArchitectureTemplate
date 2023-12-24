import Foundation

enum ViewModels {
    @MainActor
    enum Sample {
        static func Detail(modelObject: SampleModelObject) -> SampleDetailViewModel {
            .init(
                modelObject: modelObject,
                router: SampleDetailRouter(),
                analytics: FirebaseAnalytics(screenId: .sampleDetail)
            )
        }

        static func Edit(modelObject: SampleModelObject) -> SampleEditViewModel {
            .init(
                modelObject: modelObject,
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleEdit)
            )
        }
    }
}
