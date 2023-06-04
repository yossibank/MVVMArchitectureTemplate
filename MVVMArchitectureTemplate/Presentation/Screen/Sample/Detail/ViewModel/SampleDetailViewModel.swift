import Combine

final class SampleDetailViewModel: ViewModel {
    final class Input: InputObject {
        let onAppear = PassthroughSubject<Void, Never>()
    }

    final class Output: OutputObject {
        @Published fileprivate(set) var modelObject: SampleModelObject?
    }

    let input: Input
    let output: Output
    let binding = NoBinding()

    private(set) var router: SampleDetailRouterInput

    private var cancellables = Set<AnyCancellable>()

    private let modelObject: SampleModelObject
    private let analytics: FirebaseAnalyzable

    init(
        router: SampleDetailRouterInput,
        modelObject: SampleModelObject,
        analytics: FirebaseAnalyzable
    ) {
        let input = Input()
        let output = Output()

        self.input = input
        self.output = output
        self.router = router
        self.modelObject = modelObject
        self.analytics = analytics

        // 初期表示
        input.onAppear.sink {
            output.modelObject = modelObject
            analytics.sendEvent(.screenView)
        }
        .store(in: &cancellables)
    }
}
