import Foundation

@MainActor
final class SampleListViewModel: ObservableObject {
    var showPlaceholder: Bool {
        modelObjects == SampleModelObjectBuilder.placeholder
    }

    @Published var isShowErrorAlert = false
    @Published private(set) var modelObjects = SampleModelObjectBuilder.placeholder
    @Published private(set) var appError: AppError?

    private let router: SampleListRouterInput
    private let model: SampleModelInput
    private let analytics: FirebaseAnalyzable

    init(
        router: SampleListRouterInput,
        model: SampleModelInput,
        analytics: FirebaseAnalyzable
    ) {
        self.router = router
        self.model = model
        self.analytics = analytics

        // FAイベント
        analytics.sendEvent(.screenView)
    }
}

extension SampleListViewModel {
    func fetch(pullToRefresh: Bool = false) async {
        do {
            if pullToRefresh {
                try await Task.sleep(seconds: 1)
            }

            modelObjects = try await model.get(userId: nil)
        } catch {
            appError = AppError.parse(error)
            isShowErrorAlert = true
        }
    }

    func showAddView() -> SampleAddView {
        router.routeToAdd()
    }

    func showDetailView(modelObject: SampleModelObject) -> SampleDetailView {
        router.routeToDetail(modelObject: modelObject)
    }
}
