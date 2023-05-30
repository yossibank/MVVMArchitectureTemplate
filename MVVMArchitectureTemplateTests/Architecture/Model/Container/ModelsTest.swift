@testable import MVVMArchitectureTemplate
import XCTest

final class ModelsTest: XCTestCase {
    private var sampleModel: SampleModel!

    override func setUp() {
        super.setUp()

        sampleModel = Models.Sample()
    }

    func test_SampleModelのModelを生成できること() {
        // assert
        XCTAssertNotNil(sampleModel)
    }
}
