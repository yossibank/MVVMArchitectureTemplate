import Combine
import UIKit

// MARK: - inject

extension SampleListViewController: VCInjectable {
    typealias CV = SampleListContentView
    typealias VM = SampleListViewModel
}

// MARK: - stored properties & init

final class SampleListViewController: UIViewController {
    var viewModel: VM! { didSet { viewModel.routing.viewController = self } }
    var contentView: CV!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension SampleListViewController {
    override func loadView() {
        super.loadView()

        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindToView()
        bindToViewModel()
    }
}

// MARK: - private methods

private extension SampleListViewController {
    func bindToView() {
        viewModel.output.$modelObject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] modelObject in
                guard let self else {
                    return
                }

                self.contentView.modelObject = modelObject
            }
            .store(in: &cancellables)
    }

    func bindToViewModel() {
        contentView.didSelectContentPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] indexPath in
                self?.viewModel.input.contentTapped.send(indexPath)
            }
            .store(in: &cancellables)
    }
}
