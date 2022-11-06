enum ViewModels {
    enum Sample {
        static func Add() -> SampleAddViewModel {
            .init()
        }

        static func List() -> SampleListViewModel {
            .init(
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleList)
            )
        }
    }
}
