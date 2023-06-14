@testable import MVVMArchitectureTemplate
import UIKit

final class SceneDelegateMock: UIResponder, UIWindowSceneDelegate, UIAppearanceProtocol {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        if let userDefaults = UserDefaults(suiteName: "test") {
            UserDefaults.inject(userDefaults)
        }

        configureAppearance()

        window = .init(windowScene: windowScene)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
    }
}
