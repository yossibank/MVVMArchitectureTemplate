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
            let viewController = SampleDetailViewController()
            let routing = SampleDetailRouting(viewController: viewController)

            viewController.title = "サンプル詳細"
            viewController.inject(
                contentView: ContentViews.Sample.Detail(modelObject: modelObject),
                viewModel: ViewModels.Sample.Detail(
                    modelObject: modelObject,
                    routing: routing
                )
            )

            return viewController
        }

        static func Edit(_ modelObject: SampleModelObject) -> UIHostingController<SampleEditView> {
            let rootView = SampleEditView(viewModel: ViewModels.Sample.Edit(modelObject: modelObject))
            let instance = UIHostingController(rootView: rootView)

            instance.title = "サンプル編集"
            return instance
        }

        static func List() -> SampleListViewController {
            let viewController = SampleListViewController()
            let routing = SampleListRouting(viewController: viewController)

            viewController.title = "サンプル一覧"
            viewController.inject(
                contentView: ContentViews.Sample.List(),
                viewModel: ViewModels.Sample.List(routing: routing)
            )

            return viewController
        }
    }
}
