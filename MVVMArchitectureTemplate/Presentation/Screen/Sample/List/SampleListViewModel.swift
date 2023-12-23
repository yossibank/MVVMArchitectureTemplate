import Foundation

final class SampleListViewModel: BaseViewModel<SampleListViewModel> {
    required init(state: State, dependency: Dependency) {
        super.init(state: state, dependency: dependency)
        dependency.analytics.sendEvent(.screenView)
    }

    func fetch(isPullToRefresh: Bool = false) async {
        do {
            if isPullToRefresh {
                try await Task.sleep(seconds: 1)
            }
            state.modelObjects = try await dependency.model.get(userId: nil)
        } catch {
            state.isShowErrorAlert = true
            state.appError = .parse(error)
        }
    }

    func addButtonTapped() {
        send(.add)
    }

    func listRowTapped(modelObject: SampleModelObject) {
        send(.detail(modelObject))
    }
}

extension SampleListViewModel {
    struct State {
        fileprivate(set) var modelObjects = SampleModelObjectBuilder.placeholder
        fileprivate(set) var appError: AppError?
        var isShowErrorAlert = false

        var showPlaceholder: Bool {
            modelObjects == SampleModelObjectBuilder.placeholder
        }
    }

    struct Dependency: Sendable {
        let model: SampleModelInput
        let analytics: FirebaseAnalyzable
    }

    enum Output {
        case add
        case detail(SampleModelObject)
    }
}
