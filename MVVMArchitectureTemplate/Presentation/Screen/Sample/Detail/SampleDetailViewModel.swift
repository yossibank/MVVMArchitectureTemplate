import Combine

final class SampleDetailViewModel: ViewModel {
    final class Input: InputObject {
        let viewWillAppear = PassthroughSubject<Void, Never>()
        let barButtonTapped = PassthroughSubject<Void, Never>()
    }

    let input: Input
    let output = NoOutput()
    let binding = NoBinding()
    let routing: SampleDetailRouting

    private var cancellables: Set<AnyCancellable> = .init()

    private let modelObject: SampleModelObject
    private let analytics: FirebaseAnalyzable

    init(
        modelObject: SampleModelObject,
        analytics: FirebaseAnalyzable
    ) {
        let input = Input()
        let routing = Routing()

        self.input = input
        self.routing = routing
        self.modelObject = modelObject
        self.analytics = analytics

        // MARK: - viewWillAppear

        input.viewWillAppear.sink { _ in
            analytics.sendEvent(.screenView)
        }
        .store(in: &cancellables)

        // MARK: - ナビゲーションボタンタップ

        input.barButtonTapped.sink { _ in
            routing.showEditScreen(modelObject: modelObject)
        }
        .store(in: &cancellables)
    }
}
