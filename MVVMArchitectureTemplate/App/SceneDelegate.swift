import SwiftUI
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate, UIAppearanceProtocol {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        configureAppearance()

        let request = SampleListScreenRequest()
        let vc = RouterService().buildViewController(request: request)
        let rootView = UINavigationController(rootViewController: vc)

        window = .init(windowScene: windowScene)
        window?.rootViewController = rootView
        window?.makeKeyAndVisible()
    }
}
