import Combine
import UIKit

// MARK: - stored properties & init

final class SampleListViewController: UIViewController {
    var viewModel: SampleListViewModel!

    private var cancellables: Set<AnyCancellable> = .init()
}

// MARK: - override methods

extension SampleListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(SampleListView())
        setupNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - private methods

private extension SampleListViewController {
    func setupNavigation() {
        let addBarButtonItem = UIBarButtonItem(
            image: .add,
            style: .plain,
            target: nil,
            action: nil
        )

        addBarButtonItem.publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.viewModel.input.barButtonTapped.send(())
            }
            .store(in: &cancellables)

        navigationItem.rightBarButtonItem = addBarButtonItem
    }

//    func bindToView() {
//        viewModel.output.$modelObject
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] modelObject in
//                guard let self else {
//                    return
//                }
//
//                self.contentView.modelObject = modelObject
//            }
//            .store(in: &cancellables)
//
//        viewModel.output.$isLoading
//            .receive(on: DispatchQueue.main)
//            .compactMap { $0 }
//            .sink { [weak self] isLoading in
//                guard let self else {
//                    return
//                }
//
//                self.contentView.configureIndicator(isLoading: isLoading)
//            }
//            .store(in: &cancellables)
//
//        viewModel.output.$error
//            .receive(on: DispatchQueue.main)
//            .compactMap { $0 }
//            .sink { error in
//                Logger.error(message: error.localizedDescription)
//            }
//            .store(in: &cancellables)
//    }
//
//    func bindToViewModel() {
//        contentView.didSelectContentPublisher
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] indexPath in
//                self?.viewModel.input.contentTapped.send(indexPath)
//            }
//            .store(in: &cancellables)
//    }
}
