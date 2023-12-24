import UIKit

@MainActor
protocol RouterServiceProtocol {
    func buildViewController<ScreenRequest: ScreenRequestProtocol>(
        request: ScreenRequest
    ) -> ScreenRequest.ViewController
}

@MainActor
final class RouterService: RouterServiceProtocol {
    func buildViewController<ScreenRequest: ScreenRequestProtocol>(
        request: ScreenRequest
    ) -> ScreenRequest.ViewController {
        switch request {
        case let request as SampleListScreenRequest:
            return build(request) as! ScreenRequest.ViewController
        default:
            fatalError("should not reach here")
        }
    }
}

private extension RouterService {
    func build(_ request: SampleListScreenRequest) -> SampleListScreenRequest.ViewController {
        let builder = SampleListScreenBuilder(
            model: SampleModel(
                apiClient: APIClient(),
                sampleConverter: SampleConverter(),
                errorConverter: AppErrorConverter()
            ),
            analytics: FirebaseAnalytics(screenId: .sampleList),
            routerService: self
        )

        return builder.buildViewController(request: request)
    }
}
