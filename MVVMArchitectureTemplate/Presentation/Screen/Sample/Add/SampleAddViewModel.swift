import Combine
import Foundation

final class SampleAddViewModel: ViewModel {
    final class Binding: BindingObject {
        @Published var title = ""
        @Published var body = ""
    }

    final class Input: InputObject {
        let addButtonTapped = PassthroughSubject<Void, Never>()
    }

    final class Output: OutputObject {
        @Published fileprivate(set) var isTitleValid = false
        @Published fileprivate(set) var isBodyValid = false
        @Published fileprivate(set) var modelObject: SampleModelObject?
        @Published fileprivate(set) var appError: AppError?
    }

    @BindableObject private(set) var binding: Binding

    let input: Input
    let output: Output
    let routing = NoRouting()

    private let model: SampleModelInput

    private var cancellables: Set<AnyCancellable> = .init()

    init(model: SampleModelInput) {
        let binding = Binding()
        let input = Input()
        let output = Output()

        self.binding = binding
        self.input = input
        self.output = output
        self.model = model

        let isTitleValid = binding.$title.map { $0.count > 15 }
        let isBodyValid = binding.$body.map { $0.count > 30 }

        input.addButtonTapped
            .sink { [weak self] _ in
                guard let self else {
                    return
                }

                model.post(parameters: .init(
                    userId: 777,
                    title: binding.title,
                    body: binding.body
                ))
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case let .failure(appError):
                        output.appError = appError

                    case .finished:
                        Logger.debug(message: "サンプル作成完了")
                    }
                } receiveValue: { modelObject in
                    output.modelObject = modelObject
                }
                .store(in: &self.cancellables)
            }
            .store(in: &cancellables)

        cancellables.formUnion([
            isTitleValid.assign(to: \.isTitleValid, on: output),
            isBodyValid.assign(to: \.isBodyValid, on: output)
        ])
    }
}
