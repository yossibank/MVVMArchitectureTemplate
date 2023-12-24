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
            .sink { [weak self] output in
                guard let self else {
                    return
                }

                switch output {
                case .add:
                    let vc = routerService.buildViewController(request: SampleAddScreenRequest())
                    navigationController?.pushViewController(vc, animated: true)

                case let .detail(modelObject):
                    let vc = routerService.buildViewController(
                        request: SampleDetailScreenRequest(modelObject: modelObject)
                    )
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
            .store(in: &cancellables)
    }
}
