import Combine

@MainActor
final class SampleEditViewModel: ObservableObject {
    @Published var title = ""
    @Published var body = ""
    @Published var isShowSuccessAlert = false
    @Published var isShowErrorAlert = false
    @Published var isEnabled = false
    @Published private(set) var titleError: ValidationError = .none
    @Published private(set) var bodyError: ValidationError = .none
    @Published private(set) var successObject: SampleModelObject?
    @Published private(set) var appError: AppError?

    private var cancellables = Set<AnyCancellable>()

    private(set) var modelObject: SampleModelObject

    private let model: SampleModelInput
    private let analytics: FirebaseAnalyzable

    init(
        modelObject: SampleModelObject,
        model: SampleModelInput,
        analytics: FirebaseAnalyzable
    ) {
        self.modelObject = modelObject
        self.model = model
        self.analytics = analytics

        // 初期表示
        analytics.sendEvent(.screenView)

        // 初期注入
        self.title = modelObject.title
        self.body = modelObject.body

        // タイトルバリデーション
        let titleError = $title.compactMap { input in
            ValidationError.editValidate(input)
        }

        // 内容バリデーション
        let bodyError = $body.compactMap { input in
            ValidationError.editValidate(input)
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

extension SampleEditViewModel {
    func update() async {
        do {
            successObject = try await model.put(
                userId: modelObject.userId,
                parameters: .init(
                    userId: modelObject.userId,
                    id: modelObject.id,
                    title: modelObject.title,
                    body: modelObject.body
                )
            )
            isShowSuccessAlert = true
        } catch {
            appError = AppError.parse(error)
            isShowErrorAlert = true
        }
    }
}
