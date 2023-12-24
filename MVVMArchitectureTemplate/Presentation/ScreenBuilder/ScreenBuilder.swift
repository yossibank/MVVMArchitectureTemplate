import SwiftUI

@MainActor
protocol ScreenBuilderProtocol {
    associatedtype ScreenRequest: ScreenRequestProtocol

    func buildViewController(request: ScreenRequest) -> ScreenRequest.ViewController
}
