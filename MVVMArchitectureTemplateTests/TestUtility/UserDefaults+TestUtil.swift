@testable import MVVMArchitectureTemplate
import XCTest

extension XCTestCase {
    func resetUserDefaults() {
        UserDefaultsKey.allCases.forEach {
            UserDefaults(suiteName: "test")?.removeObject(forKey: $0.rawValue)
        }
    }
}
