import Combine

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
    }

    @BindableObject private(set) var binding: Binding

    let input: Input
    let output: Output
    let routing = NoRouting()

    private var cancellables: Set<AnyCancellable> = .init()

    init() {
        let binding = Binding()
        let input = Input()
        let output = Output()

        let isTitleValid = binding.$title
            .map { $0.count >= 15 }

        let isBodyValid = binding.$body
            .map { $0.count >= 30 }

        cancellables.formUnion([
            isTitleValid.assign(to: \.isTitleValid, on: output),
            isBodyValid.assign(to: \.isBodyValid, on: output)
        ])

        self.binding = binding
        self.input = input
        self.output = output
    }
}
