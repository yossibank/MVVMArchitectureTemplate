import SwiftUI

enum AppControllers {
    enum Sample {
        static func Add() -> SampleAddViewController {
            let vc = SampleAddViewController()

            vc.title = "サンプル作成"
            vc.inject(
                contentView: .init(),
                viewModel: .init(
                    model: Models.Sample(),
                    analytics: FirebaseAnalytics(screenId: .sampleAdd)
                )
            )

            return vc
        }

        static func Detail(_ modelObject: SampleModelObject) -> SampleDetailViewController {
            let vc = SampleDetailViewController()
            let routing = SampleDetailRouting(viewController: vc)

            vc.title = "サンプル詳細"
            vc.inject(
                contentView: .init(modelObject: modelObject),
                viewModel: .init(
                    modelObject: modelObject,
                    routing: routing,
                    analytics: FirebaseAnalytics(screenId: .sampleDetail)
                )
            )

            return vc
        }

        static func Edit(_ modelObject: SampleModelObject) -> SampleEditViewController {
            let vc = SampleEditViewController()

            vc.title = "サンプル編集"
            vc.inject(
                contentView: .init(modelObject: modelObject),
                viewModel: .init(
                    model: Models.Sample(),
                    modelObject: modelObject,
                    analytics: FirebaseAnalytics(screenId: .sampleEdit)
                )
            )

            return vc
        }

        static func List() -> SampleListViewController {
            let vc = SampleListViewController()
            let routing = SampleListRouting(viewController: vc)

            vc.title = "サンプル一覧"
            vc.viewModel = .init(
                model: Models.Sample(),
                routing: routing,
                analytics: FirebaseAnalytics(screenId: .sampleList)
            )

            return vc
        }
    }
}
