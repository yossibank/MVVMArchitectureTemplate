import UIKit

protocol UIAppearanceProtocol {
    func configureAppearance()
}

extension UIAppearanceProtocol {
    func configureAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .dynamicColor(light: .white, dark: .black)
        appearance.shadowColor = .clear
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
