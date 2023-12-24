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
        case let request as SampleAddScreenRequest:
            return build(request) as! ScreenRequest.ViewController
        case let request as SampleDetailScreenRequest:
            return build(request) as! ScreenRequest.ViewController
        default:
            fatalError("should not reach here")
        }
    }
}

private extension RouterService {
    func build(_ request: SampleAddScreenRequest) -> SampleAddScreenRequest.ViewController {
        let builder = SampleAddScreenBuilder(
            model: SampleModel(
                apiClient: APIClient(),
                sampleConverter: SampleConverter(),
                errorConverter: AppErrorConverter()
            ),
            analytics: FirebaseAnalytics(screenId: .sampleAdd)
        )

        return builder.buildViewController(request: request)
    }

    func build(_ request: SampleDetailScreenRequest) -> SampleDetailScreenRequest.ViewController {
        let builder = SampleDetailScreenBuilder(
            modelObject: request.modelObject,
            analytics: FirebaseAnalytics(screenId: .sampleDetail),
            routerService: self
        )

        return builder.buildViewController(request: request)
    }

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
