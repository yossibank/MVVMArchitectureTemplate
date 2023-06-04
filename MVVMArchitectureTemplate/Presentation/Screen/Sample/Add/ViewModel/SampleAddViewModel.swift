import Combine
import Foundation

final class SampleAddViewModel: ViewModel {
    final class Input: InputObject {
        let onAppear = PassthroughSubject<Void, Never>()
        let didTapCreateButton = PassthroughSubject<Void, Never>()
    }

    final class Output: OutputObject {
        @Published fileprivate(set) var titleError: ValidationError = .none
        @Published fileprivate(set) var bodyError: ValidationError = .none
        @Published fileprivate(set) var isEnabled = false
        @Published fileprivate(set) var modelObject: SampleModelObject?
        @Published fileprivate(set) var appError: AppError?
    }

    final class Binding: BindingObject {
        @Published var title = ""
        @Published var body = ""
    }

    @BindableObject private(set) var binding: Binding

    let input: Input
    let output: Output

    private var cancellables = Set<AnyCancellable>()

    private let model: SampleModelInput
    private let analytics: FirebaseAnalyzable

    init(
        model: SampleModelInput,
        analytics: FirebaseAnalyzable
    ) {
        let input = Input()
        let output = Output()
        let binding = Binding()

        self.input = input
        self.output = output
        self.binding = binding
        self.model = model
        self.analytics = analytics

        // 初期表示
        input.onAppear.sink {
            analytics.sendEvent(.screenView)
        }
        .store(in: &cancellables)

        // 各バリデーション
        let titleError = binding.$title.dropFirst().compactMap { [weak self] input in
            self?.validation(input)
        }

        let bodyError = binding.$body.dropFirst().compactMap { [weak self] input in
            self?.validation(input)
        }

        let isEnabled = Publishers.CombineLatest(
            titleError,
            bodyError
        ).map { title, body in
            title.isEnabled && body.isEnabled
        }

        // 作成ボタンタップ
        input.didTapCreateButton.flatMap {
            model.post(parameters: .init(
                userId: 1,
                title: binding.title,
                body: binding.body
            ))
        }
        .receive(on: DispatchQueue.main)
        .sink {
            if case let .failure(appError) = $0 {
                output.appError = appError
            }
        } receiveValue: { modelObject in
            output.modelObject = modelObject
        }
        .store(in: &cancellables)

        cancellables.formUnion([
            titleError.assignNoRetain(to: \.titleError, on: output),
            bodyError.assignNoRetain(to: \.bodyError, on: output),
            isEnabled.assignNoRetain(to: \.isEnabled, on: output)
        ])
    }
}

private extension SampleAddViewModel {
    func validation(_ input: String) -> ValidationError {
        if input.isEmpty {
            return .empty
        }

        if input.count > 20 {
            return .long
        }

        return .none
    }
}
