@testable import MVVMArchitectureTemplate
import XCTest

final class NSObjectExtensionTest: XCTestCase {
    func test_className_クラス名がStringで取得できること() {
        // assert
        XCTAssertEqual(
            NSObjectExtensionTest.className,
            "NSObjectExtensionTest"
        )
    }
}
