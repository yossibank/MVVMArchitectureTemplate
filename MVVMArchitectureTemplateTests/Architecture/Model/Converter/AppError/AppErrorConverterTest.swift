@testable import MVVMArchitectureTemplate
import XCTest

final class AppErrorConverterTest: XCTestCase {
    private var converter: AppErrorConverter!

    override func setUp() {
        super.setUp()

        converter = .init()
    }

    func test_APIErrorをAppErrorに変換できること() {
        // arrange
        let input = APIError.invalidRequest

        // act
        let actual = converter.convert(input)

        // assert
        XCTAssertEqual(
            actual,
            .init(apiError: .invalidRequest)
        )
    }
}
