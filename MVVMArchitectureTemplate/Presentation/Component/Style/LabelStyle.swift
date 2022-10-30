import UIKit

extension ViewStyle where T: UILabel {
    // MARK: - 共通セル

    static var title: ViewStyle<T> {
        .init {
            $0.font = .boldSystemFont(ofSize: 14)
            $0.numberOfLines = 2
        }
    }

    static var subTitle: ViewStyle<T> {
        .init {
            $0.font = .systemFont(ofSize: 12)
            $0.numberOfLines = 1
        }
    }

    static var number: ViewStyle<T> {
        .init {
            $0.font = .systemFont(ofSize: 10)
        }
    }
}
