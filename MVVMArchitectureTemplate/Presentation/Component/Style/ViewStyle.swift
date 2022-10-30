import UIKit

extension ViewStyle where T: UIView {
    // MARK: - 基本背景

    static var background: ViewStyle<T> {
        .init {
            $0.backgroundColor = .systemBackground
        }
    }
}
