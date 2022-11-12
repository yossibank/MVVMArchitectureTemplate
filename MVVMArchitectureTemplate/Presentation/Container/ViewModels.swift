enum ViewModels {
    enum Sample {
        static func Add() -> SampleAddViewModel {
            .init(model: Models.Sample())
        }

        static func Edit(modelObject: SampleModelObject) -> SampleEditViewModel {
            .init(
                model: Models.Sample(),
                modelObject: modelObject,
                analytics: FirebaseAnalytics(screenId: .sampleList)
            )
        }

        static func List() -> SampleListViewModel {
            .init(
                model: Models.Sample(),
                analytics: FirebaseAnalytics(screenId: .sampleList)
            )
        }
    }
}
