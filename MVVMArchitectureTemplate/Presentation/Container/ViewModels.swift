import Foundation

enum ViewModels {
    enum Sample {
        static func Add() -> SampleAddSwiftUIViewModel {
            .init(
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleAdd)
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
