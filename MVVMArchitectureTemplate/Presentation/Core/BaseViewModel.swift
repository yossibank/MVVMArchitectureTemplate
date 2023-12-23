import Combine

protocol LogicProtocol {
    associatedtype State
    associatedtype Dependency = Void
    associatedtype Output = Void
}

typealias BaseViewModel<Logic: LogicProtocol> = ViewModel<Logic> & LogicProtocol

@MainActor
class ViewModel<Logic: LogicProtocol>: ObservableObject {
    typealias State = Logic.State
    typealias Dependency = Logic.Dependency
    typealias Output = Logic.Output

    @Published var state: State
    let dependency: Dependency
    let output: AnyPublisher<Output, Never>
    private let outputSubject = PassthroughSubject<Logic.Output, Never>()
    private var cancellables = Set<AnyCancellable>()

    required init(state: Logic.State, dependency: Logic.Dependency) {
        self.state = state
        self.dependency = dependency
        self.output = outputSubject.eraseToAnyPublisher()
    }

    convenience init(state: Logic.State) where Logic.Dependency == Void {
        self.init(state: state, dependency: ())
    }

    func send(_ output: Logic.Output) {
        outputSubject.send(output)
    }
}
