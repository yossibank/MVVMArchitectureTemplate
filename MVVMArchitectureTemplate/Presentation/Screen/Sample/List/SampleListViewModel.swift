import Combine
import Foundation

final class SampleListViewModel: ViewModel {
    final class Input: InputObject {
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
    let routing: SampleListRouting

    private var cancellables: Set<AnyCancellable> = .init()

    private let model: SampleModelInput
    private let analytics: FirebaseAnalyzable

    init(
        model: SampleModelInput,
        analytics: FirebaseAnalyzable
    ) {
        let input = Input()
        let output = Output()
        let routing = Routing()

        self.model = model
        self.input = input
        self.output = output
        self.routing = routing
        self.analytics = analytics

        // MARK: - 詳細API取得

        output.isLoading = true

        model.get(userId: nil).sink { completion in
            output.isLoading = false

            switch completion {
            case let .failure(error):
                output.error = error

            case .finished:
                Logger.debug(message: "詳細API読み込み完了")
            }
        } receiveValue: { modelObject in
            output.modelObject = modelObject
        }
        .store(in: &cancellables)

        // MARK: - viewWillAppear

        input.viewWillAppear.sink { _ in
            analytics.sendvent(.screenView)
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
            analytics.sendvent(.tapSmapleList(userId: modelObject.userId))
            routing.showDetailScreen(modelObject)
        }
        .store(in: &cancellables)
    }
}
