import Foundation

enum ViewModels {
    @MainActor
    enum Sample {
        static func Add() -> SampleAddViewModel {
            .init(
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleAdd)
            )
        }

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

        static func List() -> SampleListViewModel {
            .init(
                router: SampleListRouter(),
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleList)
            )
        }
    }
}
