import Combine
import SwiftUI

final class SampleAddViewController: UIHostingController<SampleAddScreenView> {
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: SampleAddViewModel

    init(
        rootView: SampleAddScreenView,
        viewModel: SampleAddViewModel
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
        title = "サンプル追加"
    }

    private func setupBinding() {
        viewModel.output
            .receive(on: DispatchQueue.main)
            .weakSink(with: self, cancellables: &cancellables) {
                switch $1 {
                case .dismiss:
                    $0.navigationController?.popViewController(animated: true)
                }
            }
    }
}
