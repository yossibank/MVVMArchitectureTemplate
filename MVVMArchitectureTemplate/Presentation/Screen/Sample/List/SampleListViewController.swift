import Combine
import SwiftUI

final class SampleListViewController: UIHostingController<SampleListScreenView> {
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: SampleListViewModel
    private let routerService: RouterServiceProtocol

    init(
        rootView: SampleListScreenView,
        viewModel: SampleListViewModel,
        routerService: RouterServiceProtocol
    ) {
        self.viewModel = viewModel
        self.routerService = routerService
        super.init(rootView: rootView)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBinding()
    }

    private func setupView() {
        title = "サンプル一覧"
    }

    private func setupBinding() {
        viewModel.output
            .receive(on: DispatchQueue.main)
            .weakSink(with: self, cancellables: &cancellables) {
                switch $1 {
                case .add:
                    let vc = $0.routerService.buildViewController(request: SampleAddScreenRequest())
                    $0.navigationController?.pushViewController(vc, animated: true)

                case let .detail(modelObject):
                    let vc = $0.routerService.buildViewController(
                        request: SampleDetailScreenRequest(modelObject: modelObject)
                    )
                    $0.navigationController?.pushViewController(vc, animated: true)
                }
            }
    }
}
