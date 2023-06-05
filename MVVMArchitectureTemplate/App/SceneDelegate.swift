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

        window = .init(windowScene: windowScene)
        window?.rootViewController = UIHostingController(
            rootView: SampleListView(
                viewModel: ViewModels.Sample.List()
            )
        )
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
