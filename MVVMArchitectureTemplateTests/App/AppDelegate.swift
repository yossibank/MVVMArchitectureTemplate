@testable import MVVMArchitectureTemplate
import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = .init()
        window?.rootViewController = .init()
        window?.makeKeyAndVisible()

        if let userDefaults = UserDefaults(suiteName: "test") {
            UserDefaults.inject(userDefaults)
        }

        return true
    }
}
