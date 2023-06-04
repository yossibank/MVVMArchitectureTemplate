import Foundation

enum ViewModels {
    enum Sample {
        static func Add() -> SampleAddViewModel {
            .init(
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleAdd)
            )
        }

        static func Detail(modelObject: SampleModelObject) -> SampleDetailSwiftUIViewModel {
            .init(
                router: SampleDetailRouter(),
                modelObject: modelObject,
                analytics: FirebaseAnalytics(screenId: .sampleDetail)
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
