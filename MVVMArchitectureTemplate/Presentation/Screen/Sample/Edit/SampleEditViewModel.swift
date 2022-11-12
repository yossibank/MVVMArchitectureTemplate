import Combine
import Foundation

final class SampleEditViewModel: ViewModel {
    final class Binding: BindingObject {
        @Published var title = ""
        @Published var body = ""
        @Published var isCompleted = false
    }

    final class Input: InputObject {
        let editButtonTapped = PassthroughSubject<Void, Never>()
    }

    final class Output: OutputObject {
        @Published fileprivate(set) var modelObject: SampleModelObject?
        @Published fileprivate(set) var appError: AppError?
    }

    @BindableObject private(set) var binding: Binding

    let input: Input
    let output: Output
    let routing = NoRouting()

    private var cancellables: Set<AnyCancellable> = .init()

    private let model: SampleModelInput
    private let modelObject: SampleModelObject
    private let analytics: FirebaseAnalyzable

    init(
        model: SampleModelInput,
        modelObject: SampleModelObject,
        analytics: FirebaseAnalyzable
    ) {
        let binding = Binding()
        let input = Input()
        let output = Output()

        self.binding = binding
        self.input = input
        self.output = output
        self.model = model
        self.modelObject = modelObject
        self.analytics = analytics

        binding.title = modelObject.title
        binding.body = modelObject.body

        // MARK: - 編集ボタンタップ

        input.editButtonTapped
            .flatMap {
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
            .sink { completion in
                switch completion {
                case let .failure(appError):
                    binding.isCompleted = true
                    output.appError = appError

                case .finished:
                    Logger.debug(message: "サンプル編集完了")
                }
            } receiveValue: { modelObject in
                binding.isCompleted = true
                output.modelObject = modelObject
            }
            .store(in: &cancellables)
    }
}
