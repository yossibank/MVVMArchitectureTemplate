import Foundation

@MainActor
final class SampleEditViewModel: BaseViewModel<SampleEditViewModel> {
    required init(state: State, dependency: Dependency) {
        super.init(state: state, dependency: dependency)

        dependency.analytics.sendEvent(.screenView)
    }

    func update() async {
        do {
            state.successObject = try await dependency.model.put(
                userId: state.modelObject.userId,
                parameters: .init(
                    userId: state.modelObject.userId,
                    id: state.modelObject.id,
                    title: state.modelObject.title,
                    body: state.modelObject.body
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

extension SampleEditViewModel {
    struct State {
        var isShowSuccessAlert = false
        var isShowErrorAlert = false
        var modelObject: SampleModelObject
        fileprivate(set) var successObject: SampleModelObject?
        fileprivate(set) var appError: AppError?

        var titleError: ValidationError {
            .editValidate(modelObject.title)
        }

        var bodyError: ValidationError {
            .editValidate(modelObject.body)
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
