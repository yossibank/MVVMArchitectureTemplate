import Foundation

@MainActor
final class SampleDetailViewModel: BaseViewModel<SampleDetailViewModel> {
    required init(state: State, dependency: Dependency) {
        super.init(state: state, dependency: dependency)

        dependency.analytics.sendEvent(.screenView)
    }

    func editButtonTapped() {
        send(.edit(state.modelObject))
    }
}

extension SampleDetailViewModel {
    struct State {
        let modelObject: SampleModelObject
    }

    struct Dependency {
        let analytics: FirebaseAnalyzable
    }

    enum Output {
        case edit(SampleModelObject)
    }
}
