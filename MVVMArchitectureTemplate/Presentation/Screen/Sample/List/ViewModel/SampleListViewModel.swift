import Combine
import Foundation

final class SampleListViewModel: ViewModel {
    final class Input: InputObject {
        let onAppear = PassthroughSubject<Void, Never>()
        let viewRefresh = PassthroughSubject<Void, Never>()
    }

    final class Output: OutputObject {
        @Published fileprivate(set) var isLoading = false
        @Published fileprivate(set) var placeholder: [SampleModelObject] = []
        @Published fileprivate(set) var modelObjects: [SampleModelObject] = []
        @Published fileprivate(set) var appError: AppError?
    }

    final class Binding: BindingObject {
        @Published var isShowErrorAlert = false
    }

    @BindableObject private(set) var binding: Binding

    let input: Input
    let output: Output

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
        let binding = Binding()

        self.input = input
        self.output = output
        self.binding = binding
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
        input.viewRefresh.sink { [weak self] _ in
            self?.fetch()
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
                    self?.binding.isShowErrorAlert = true
                }
            } receiveValue: { [weak self] modelObjects in
                self?.output.modelObjects = modelObjects
            }
            .store(in: &cancellables)
    }
}
