import SwiftUI

enum AppControllers {
    enum Sample {
        static func Add() -> UIHostingController<SampleAddView> {
            let rootView = SampleAddView()
            let instance = UIHostingController(rootView: rootView)

            instance.title = "サンプル作成"
            return instance
        }

        static func Detail(_ modelObject: SampleModelObject) -> UIHostingController<SampleDetailView> {
            let rootView = SampleDetailView(modelObject: modelObject)
            let instance = UIHostingController(rootView: rootView)

            instance.title = "サンプル詳細"
            return instance
        }

        static func List() -> SampleListViewController {
            let instance = SampleListViewController()

            instance.inject(
                contentView: ContentViews.Sample.List(),
                viewModel: ViewModels.Sample.List()
            )

            instance.title = "サンプル一覧"
            return instance
        }
    }
}
