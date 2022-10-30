import UIKit

struct ViewStyle<T> {
    let style: (T) -> Void
}

extension ViewStyle {
    func compose(with style: ViewStyle<T>) -> ViewStyle<T> {
        .init {
            self.style($0)
            style.style($0)
        }
    }
}

protocol Stylable {
    init()
}

extension Stylable {
    init(style: ViewStyle<Self>) {
        self.init()
        apply(style)
    }

    func apply(_ style: ViewStyle<Self>) {
        style.style(self)
    }
}

extension UIView: Stylable {}
