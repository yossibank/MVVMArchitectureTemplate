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
            .sink { output in
                switch output {
                case .add:
                    print("追加画面遷移")

                case let .detail(modelObject):
                    print("詳細画面遷移")
                }
            }
            .store(in: &cancellables)
    }
}
