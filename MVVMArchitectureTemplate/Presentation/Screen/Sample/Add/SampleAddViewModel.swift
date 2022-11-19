import Combine
import Foundation

final class SampleAddViewModel: ViewModel {
    final class Binding: BindingObject {
        @Published var title = ""
        @Published var body = ""
        @Published var isCompleted = false
    }

    final class Input: InputObject {
        let addButtonTapped = PassthroughSubject<Void, Never>()
    }

    final class Output: OutputObject {
        @Published fileprivate(set) var isEnabledTitle = false
        @Published fileprivate(set) var isEnabledBody = false
        @Published fileprivate(set) var modelObject: SampleModelObject?
        @Published fileprivate(set) var appError: AppError?
    }

    @BindableObject private(set) var binding: Binding

    let input: Input
    let output: Output
    let routing = NoRouting()

    private var cancellables: Set<AnyCancellable> = .init()

    private let model: SampleModelInput
    private let analytics: FirebaseAnalyzable

    init(
        model: SampleModelInput,
        analytics: FirebaseAnalyzable
    ) {
        let binding = Binding()
        let input = Input()
        let output = Output()

        self.binding = binding
        self.input = input
        self.output = output
        self.model = model
        self.analytics = analytics

        // MARK: - タイトルバリデーション

        let isEnabledTitle = binding.$title.map { $0.count <= 15 }

        // MARK: - 内容バリデーション

        let isEnabledBody = binding.$body.map { $0.count <= 30 }

        // MARK: - 登録ボタンタップ

        input.addButtonTapped
            .flatMap {
                model.post(parameters: .init(
                    userId: 777,
                    title: binding.title,
                    body: binding.body
                ))
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case let .failure(appError):
                    binding.isCompleted = true
                    output.appError = appError

                case .finished:
                    Logger.debug(message: "サンプル作成完了")
                }
            } receiveValue: { modelObject in
                binding.isCompleted = true
                output.modelObject = modelObject
            }
            .store(in: &cancellables)

        cancellables.formUnion([
            isEnabledTitle.assign(to: \.isEnabledTitle, on: output),
            isEnabledBody.assign(to: \.isEnabledBody, on: output)
        ])
    }
}
