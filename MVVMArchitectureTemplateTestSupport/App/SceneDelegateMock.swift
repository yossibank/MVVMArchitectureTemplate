@testable import MVVMArchitectureTemplate
import UIKit

final class Shared {
    var windowScene: UIWindowScene?

    private init() {}

    static let shared = Shared()
}

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

        Shared.shared.windowScene = windowScene

        if let userDefaults = UserDefaults(suiteName: "test") {
            UserDefaults.inject(userDefaults)
        }

        configureAppearance()

        window = .init(windowScene: windowScene)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
