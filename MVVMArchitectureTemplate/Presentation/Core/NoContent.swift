import UIKit

final class NoContentView: UIView, ContentView {
    func setupViews() {
        assertionFailure("実装する必要がありません")
    }

    func setupConstraints() {
        assertionFailure("実装する必要がありません")
    }
}

final class NoInput: InputObject {}

final class NoOutput: OutputObject {}

final class NoBinding: BindingObject {}

final class NoRouting: RoutingObject {
    var viewController: UIViewController?
}

final class NoViewModel: ViewModel {
    var input: NoInput
    var output: NoOutput
    var binding: NoBinding
    var routing: NoRouting

    init() {
        self.input = .init()
        self.output = .init()
        self.binding = .init()
        self.routing = .init()
    }
}
