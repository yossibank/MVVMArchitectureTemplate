enum ViewModels {
    enum Sample {
        static func List() -> SampleListViewModel {
            .init(model: Models.Sample())
        }
    }
}
