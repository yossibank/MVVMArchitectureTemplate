import Combine
import SwiftUI

final class SampleEditViewController: UIHostingController<SampleEditScreenView> {
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: SampleEditViewModel

    init(
        rootView: SampleEditScreenView,
        viewModel: SampleEditViewModel
    ) {
        self.viewModel = viewModel
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
        title = "サンプル編集"
    }

    private func setupBinding() {
        viewModel.output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] output in
                switch output {
                case .dismiss:
                    self?.dismiss(animated: true)
                }
            }
            .store(in: &cancellables)
    }
}
