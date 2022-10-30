import Combine
import Foundation

final class SampleListViewModel: ViewModel {
    final class Input: InputObject {
        let contentTapped = PassthroughSubject<IndexPath, Never>()
    }

    final class Output: OutputObject {
        @Published fileprivate(set) var modelObject: [SampleModelObject] = []
        @Published fileprivate(set) var error: APIError?
    }

    let input: Input
    let output: Output
    let binding = NoBinding()
    let routing = NoRouting()

    private var cancellables: Set<AnyCancellable> = .init()

    private let model: SampleModelInput

    init(model: SampleModelInput) {
        let input = Input()
        let output = Output()

        self.model = model
        self.input = input
        self.output = output

        // MARK: - 詳細API取得

        model.get(userId: nil).sink { completion in
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

        // MARK: - セルタップ

        input.contentTapped.sink { indexPath in
            Logger.debug(message: "\(indexPath)")
        }
        .store(in: &cancellables)
    }
}
