import SwiftUI

enum AppControllers {
    enum Sample {
        static func Add() -> UIHostingController<SampleAddView> {
            let rootView = SampleAddView(viewModel: ViewModels.Sample.Add())
            let instance = UIHostingController(rootView: rootView)

            instance.title = "サンプル作成"
            return instance
        }

        static func Detail(_ modelObject: SampleModelObject) -> SampleDetailViewController {
            let instance = SampleDetailViewController()

            instance.inject(
                contentView: ContentViews.Sample.Detail(modelObject: modelObject),
                viewModel: ViewModels.Sample.Detail(modelObject: modelObject)
            )
            instance.title = "サンプル詳細"

            return instance
        }

        static func Edit(_ modelObject: SampleModelObject) -> UIHostingController<SampleEditView> {
            let rootView = SampleEditView(viewModel: ViewModels.Sample.Edit(modelObject: modelObject))
            let instance = UIHostingController(rootView: rootView)

            instance.title = "サンプル編集"
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
