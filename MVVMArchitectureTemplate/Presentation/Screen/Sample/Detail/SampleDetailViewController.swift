import Combine
import SwiftUI

final class SampleDetailViewController: UIHostingController<SampleDetailScreenView> {
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: SampleDetailViewModel
    private let routerService: RouterServiceProtocol

    init(
        rootView: SampleDetailScreenView,
        viewModel: SampleDetailViewModel,
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
        title = "サンプル詳細"
    }

    private func setupBinding() {
        viewModel.output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] output in
                guard let self else {
                    return
                }

                switch output {
                case let .edit(modelObject):
                    let vc = routerService.buildViewController(
                        request: SampleEditScreenRequest(modelObject: modelObject)
                    )
                    present(UINavigationController(rootViewController: vc), animated: true)
                }
            }
            .store(in: &cancellables)
    }
}
