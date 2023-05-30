@testable import MVVMArchitectureTemplate
import XCTest

final class FAEventTest: XCTestCase {
    func test_FAEvent_nameの値が返却できていること() {
        XCTAssertEqual(
            FAEvent.screenView.name,
            "画面表示"
        )

        XCTAssertEqual(
            FAEvent.tapSmapleList(userId: 1).name,
            "サンプル一覧タップ"
        )
    }

    func test_FAEvent_parameterの値が返却できてること() {
        XCTAssertTrue(FAEvent.screenView.parameter.isEmpty)

        XCTAssertEqual(
            FAEvent.tapSmapleList(userId: 1).parameter[FAParameter.userId.rawValue] as? Int,
            1
        )
    }
}
