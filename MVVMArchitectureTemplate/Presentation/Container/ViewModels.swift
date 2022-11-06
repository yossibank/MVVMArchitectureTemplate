enum ViewModels {
    enum Sample {
        static func Add() -> SampleAddViewModel {
            .init(model: Models.Sample())
        }

        static func List() -> SampleListViewModel {
            .init(
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleList)
            )
        }
    }
}
