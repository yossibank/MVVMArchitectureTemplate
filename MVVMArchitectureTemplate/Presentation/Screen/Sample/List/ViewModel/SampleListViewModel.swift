import Combine
import SwiftUI

final class SampleListViewModel: ViewModel {
    final class Input: InputObject {
        let onAppear = PassthroughSubject<Void, Never>()
        let pullToRefresh = PassthroughSubject<Void, Never>()
    }

    final class Output: OutputObject {
        @Published fileprivate(set) var isLoading = false
        @Published fileprivate(set) var placeholder: [SampleModelObject] = []
        @Published fileprivate(set) var modelObjects: [SampleModelObject] = []
        @Published fileprivate(set) var appError: AppError?
    }

    let input: Input
    let output: Output
    let binding = NoBinding()

    private(set) var router: SampleListRouterInput

    private var cancellables = Set<AnyCancellable>()

    private let model: SampleModelInput
    private let analytics: FirebaseAnalyzable

    init(
        router: SampleListRouterInput,
        model: SampleModelInput,
        analytics: FirebaseAnalyzable
    ) {
        let input = Input()
        let output = Output()

        self.input = input
        self.output = output
        self.router = router
        self.model = model
        self.analytics = analytics

        // プレースホルダー
        output.placeholder = SampleModelObjectBuilder.placeholder

        // 初期表示
        input.onAppear.sink { [weak self] _ in
            self?.fetch()
            self?.analytics.sendEvent(.screenView)
        }
        .store(in: &cancellables)

        // 引っ張り更新
        input.pullToRefresh.sink { [weak self] _ in
            self?.pullToRefresh()
        }
        .store(in: &cancellables)
    }
}

private extension SampleListViewModel {
    func fetch() {
        output.isLoading = true

        model.get(userId: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.output.isLoading = false

                if case let .failure(appError) = $0 {
                    self?.output.appError = appError
                }
            } receiveValue: { [weak self] modelObjects in
                self?.output.modelObjects = modelObjects
            }
            .store(in: &cancellables)
    }

    func pullToRefresh() {
        model.get(userId: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if case let .failure(appError) = $0 {
                    self?.output.appError = appError
                }
            } receiveValue: { [weak self] modelObjects in
                self?.output.modelObjects = modelObjects
            }
            .store(in: &cancellables)
    }
}
