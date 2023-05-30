import Combine
import Foundation

final class SampleListViewModel: ViewModel {
    final class Input: InputObject {
        let viewDidLoad = PassthroughSubject<Void, Never>()
        let viewWillAppear = PassthroughSubject<Void, Never>()
        let barButtonTapped = PassthroughSubject<Void, Never>()
        let contentTapped = PassthroughSubject<IndexPath, Never>()
    }

    final class Output: OutputObject {
        @Published fileprivate(set) var modelObject: [SampleModelObject] = []
        @Published fileprivate(set) var isLoading: Bool?
        @Published fileprivate(set) var error: AppError?
    }

    let input: Input
    let output: Output
    let binding = NoBinding()

    private var cancellables: Set<AnyCancellable> = .init()

    private let model: SampleModelInput
    private let routing: SampleListRoutingInput
    private let analytics: FirebaseAnalyzable

    init(
        model: SampleModelInput,
        routing: SampleListRoutingInput,
        analytics: FirebaseAnalyzable
    ) {
        let input = Input()
        let output = Output()

        self.input = input
        self.output = output
        self.model = model
        self.routing = routing
        self.analytics = analytics

        // MARK: - viewDidLoad

        input.viewDidLoad.sink { [weak self] _ in
            self?.fetch()
        }
        .store(in: &cancellables)

        // MARK: - viewWillAppear

        input.viewWillAppear.sink { _ in
            analytics.sendEvent(.screenView)
        }
        .store(in: &cancellables)

        // MARK: - ナビゲーションボタンタップ

        input.barButtonTapped.sink { _ in
            routing.showAddScreen()
        }
        .store(in: &cancellables)

        // MARK: - セルタップ

        input.contentTapped.sink { indexPath in
            let modelObject = output.modelObject[indexPath.row]
            analytics.sendEvent(.tapSmapleList(userId: modelObject.userId))
            routing.showDetailScreen(modelObject)
        }
        .store(in: &cancellables)
    }
}

// MARK: - private methods

private extension SampleListViewModel {
    func fetch() {
        output.isLoading = true

        model.get(userId: nil).sink { [weak self] completion in
            self?.output.isLoading = false

            if case let .failure(error) = completion {
                self?.output.error = error
            }
        } receiveValue: { [weak self] modelObject in
            self?.output.modelObject = modelObject
        }
        .store(in: &cancellables)
    }
}
