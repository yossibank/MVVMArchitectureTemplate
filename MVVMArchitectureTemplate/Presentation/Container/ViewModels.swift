import Foundation

enum ViewModels {
    enum Sample {
        static func List() -> SampleListViewModel {
            .init(
                router: SampleListRouter(),
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleList)
            )
        }
    }
}
