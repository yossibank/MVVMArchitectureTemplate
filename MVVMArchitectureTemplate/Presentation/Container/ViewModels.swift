import Foundation

enum ViewModels {
    enum Sample {
        @MainActor
        static func Add() -> SampleAddViewModel {
            .init(
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleAdd)
            )
        }

        static func Detail(modelObject: SampleModelObject) -> SampleDetailViewModel {
            .init(
                router: SampleDetailRouter(),
                modelObject: modelObject,
                analytics: FirebaseAnalytics(screenId: .sampleDetail)
            )
        }

        static func Edit(modelObject: SampleModelObject) -> SampleEditViewModel {
            .init(
                model: Models.Sample(),
                modelObject: modelObject,
                analytics: FirebaseAnalytics(screenId: .sampleEdit)
            )
        }

        @MainActor
        static func List() -> SampleListViewModel {
            .init(
                router: SampleListRouter(),
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleList)
            )
        }
    }
}
