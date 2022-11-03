import SwiftUI

enum AppControllers {
    enum Sample {
        static func Get() -> SampleListViewController {
            let instance = SampleListViewController()

            instance.inject(
                contentView: .init(),
                viewModel: .init(model: SampleModel(
                    apiClient: APIClient(),
                    sampleConverter: SampleConverter(),
                    errorConverter: AppErrorConverter()
                ))
            )

            instance.title = "サンプル一覧"
            return instance
        }

        static func Detail(_ modelObject: SampleModelObject) -> UIHostingController<SampleDetailView> {
            let rootView = SampleDetailView(modelObject: modelObject)
            let instance = UIHostingController(rootView: rootView)

            instance.title = "サンプル詳細"
            return instance
        }
    }
}
