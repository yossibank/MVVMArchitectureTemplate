enum AppControllers {
    enum Sample {
        static func Get() -> SampleListViewController {
            let instance = SampleListViewController()

            instance.inject(
                contentView: .init(),
                viewModel: .init(model: SampleModel(
                    apiClient: APIClient(),
                    converter: SampleConverter()
                ))
            )

            instance.title = "サンプル一覧"

            return instance
        }
    }
}
