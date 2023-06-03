import Foundation

enum ViewModels {
    enum Sample {
        static func List() -> SampleListSwiftUIViewModel {
            .init(
                router: SampleListRouter(),
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleList)
            )
        }
    }
}
