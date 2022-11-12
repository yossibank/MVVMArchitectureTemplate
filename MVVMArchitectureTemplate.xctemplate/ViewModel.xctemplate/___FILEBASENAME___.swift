import Combine

final class ___FILEBASENAME___: ViewModel {
    final class Input: InputObject {
        // ViewModelが受け取るUIイベントを必要に応じて定義、必要がない場合はNoInput()を生成
    }

    final class Output: OutputObject {
        // ViewModelが出力する値を必要に応じて定義、必要がない場合はNoOutput()を生成
    }

    let input: Input
    let output: Output
    let binding = NoBinding() // 必要に応じてBindingを生成
    let routing = NoRouting() // 必要に応じてRoutingを生成

    private var cancellables: Set<AnyCancellable> = .init()

    private let analytics: FirebaseAnalyzable

    init(analytics: FirebaseAnalyzable) {
        let input = Input()
        let output = Output()

        self.input = input
        self.output = output
        self.analytics = analytics
    }
}
