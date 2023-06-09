import Combine

@MainActor
final class SampleAddViewModel: ObservableObject {
    @Published var title = ""
    @Published var body = ""
    @Published var isEnabled = false
    @Published var isShowSuccessAlert = false
    @Published var isShowErrorAlert = false
    @Published private(set) var titleError: ValidationError = .none
    @Published private(set) var bodyError: ValidationError = .none
    @Published private(set) var successObject: SampleModelObject?
    @Published private(set) var appError: AppError?

    private var cancellables = Set<AnyCancellable>()

    private let model: SampleModelInput
    private let analytics: FirebaseAnalyzable

    init(
        model: SampleModelInput,
        analytics: FirebaseAnalyzable
    ) {
        self.model = model
        self.analytics = analytics

        // FAイベント
        analytics.sendEvent(.screenView)

        // タイトルバリデーション
        let titleError = $title.dropFirst().compactMap { input in
            ValidationError.addValidate(input)
        }

        // 内容バリデーション
        let bodyError = $body.dropFirst().compactMap { input in
            ValidationError.addValidate(input)
        }

        // ボタン有効化
        let isEnabled = Publishers.CombineLatest(
            titleError,
            bodyError
        ).map { title, body in
            title.isEnabled && body.isEnabled
        }

        // バリデーション結合
        cancellables.formUnion([
            titleError.assignNoRetain(to: \.titleError, on: self),
            bodyError.assignNoRetain(to: \.bodyError, on: self),
            isEnabled.assignNoRetain(to: \.isEnabled, on: self)
        ])
    }
}

extension SampleAddViewModel {
    func post() async {
        do {
            successObject = try await model.post(
                parameters: .init(
                    userId: 1,
                    title: title,
                    body: body
                )
            )
            isShowSuccessAlert = true
        } catch {
            appError = AppError.parse(error)
            isShowErrorAlert = true
        }
    }
}
