import UIKit

extension ViewStyle where T: UIActivityIndicatorView {
    static var main: ViewStyle<T> {
        .init {
            $0.color = .gray
            $0.transform = .init(scaleX: 1.5, y: 1.5)
        }
    }
}
