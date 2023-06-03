import Foundation

enum ViewModels {
    enum Sample {
        static func List() -> SampleListSwiftUIViewModel {
            .init(
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleList)
            )
        }
    }
}
