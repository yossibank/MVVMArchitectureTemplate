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
}
