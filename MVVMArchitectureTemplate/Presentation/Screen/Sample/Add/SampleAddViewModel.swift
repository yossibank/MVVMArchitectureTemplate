import Foundation

@MainActor
final class SampleAddViewModel: BaseViewModel<SampleAddViewModel> {
    required init(state: State, dependency: Dependency) {
        super.init(state: state, dependency: dependency)

        dependency.analytics.sendEvent(.screenView)
    }

    func post() async {
        do {
            state.successObject = try await dependency.model.post(
                parameters: .init(
                    userId: 1,
                    title: state.title,
                    body: state.body
                )
            )
            state.isShowSuccessAlert = true
        } catch {
            state.isShowErrorAlert = true
            state.appError = .parse(error)
        }
    }

    func successAlertTapped() {
        send(.dismiss)
    }
}

extension SampleAddViewModel {
    struct State {
        var title = ""
        var body = ""
        var isShowSuccessAlert = false
        var isShowErrorAlert = false
        fileprivate(set) var successObject: SampleModelObject?
        fileprivate(set) var appError: AppError?

        var titleError: ValidationError {
            .addValidate(title)
        }

        var bodyError: ValidationError {
            .addValidate(body)
        }

        var isEnabled: Bool {
            titleError.isEnabled && bodyError.isEnabled
        }
    }

    struct Dependency: Sendable {
        let model: SampleModelInput
        let analytics: FirebaseAnalyzable
    }

    enum Output {
        case dismiss
    }
}
