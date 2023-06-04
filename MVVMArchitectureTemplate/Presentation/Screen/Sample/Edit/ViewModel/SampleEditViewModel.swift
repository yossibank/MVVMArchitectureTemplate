import Combine
import Foundation

final class SampleEditViewModel: ViewModel {
    final class Input: InputObject {
        let onAppear = PassthroughSubject<Void, Never>()
        let didTapEditButton = PassthroughSubject<Void, Never>()
    }

    final class Output: OutputObject {
        @Published fileprivate(set) var titleError: ValidationError = .none
        @Published fileprivate(set) var bodyError: ValidationError = .none
        @Published fileprivate(set) var isEnabled = false
        @Published fileprivate(set) var initialModelObject: SampleModelObject?
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
    private let modelObject: SampleModelObject
    private let analytics: FirebaseAnalyzable

    init(
        model: SampleModelInput,
        modelObject: SampleModelObject,
        analytics: FirebaseAnalyzable
    ) {
        let input = Input()
        let output = Output()
        let binding = Binding()

        self.input = input
        self.output = output
        self.binding = binding
        self.model = model
        self.modelObject = modelObject
        self.analytics = analytics

        // 初期表示
        input.onAppear.sink {
            output.initialModelObject = modelObject
            binding.title = modelObject.title
            binding.body = modelObject.body
            analytics.sendEvent(.screenView)
        }
        .store(in: &cancellables)

        // 各バリデーション
        let titleError = binding.$title.compactMap { input in
            ValidationError.editValidate(input)
        }

        let bodyError = binding.$body.compactMap { input in
            ValidationError.editValidate(input)
        }

        let isEnabled = Publishers.CombineLatest(
            titleError,
            bodyError
        ).map { title, body in
            title.isEnabled && body.isEnabled
        }

        // 編集ボタンタップ
        input.didTapEditButton.flatMap {
            model.put(
                userId: modelObject.userId,
                parameters: .init(
                    userId: modelObject.userId,
                    id: modelObject.id,
                    title: binding.title,
                    body: binding.body
                )
            )
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
            isEnabled.assign(to: \.isEnabled, on: output)
        ])
    }
}
