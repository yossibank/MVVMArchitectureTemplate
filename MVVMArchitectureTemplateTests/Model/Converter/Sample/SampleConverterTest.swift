@testable import MVVMArchitectureTemplate
import XCTest

final class SampleConverterTest: XCTestCase {
    func test_SampleDataObjectをSampleModelObjectに変換できること() {
        let result = SampleConverter().convert(
            SampleDataObjectBuilder()
                .userId(1)
                .id(1)
                .title("title")
                .body("body")
                .build()
        )

        let expectation = SampleModelObjectBuilder()
            .userId(1)
            .id(1)
            .title("title")
            .body("body")
            .build()

        XCTAssertEqual(result, expectation)
    }

    func test_配列SampleDataOjbectを配列SampleModelObjectに変換できること() {
        let result = SampleConverter().convert(
            [
                SampleDataObjectBuilder()
                    .userId(1)
                    .id(1)
                    .title("title")
                    .body("body")
                    .build()
            ]
        )

        let expectation = [
            SampleModelObjectBuilder()
                .userId(1)
                .id(1)
                .title("title")
                .body("body")
                .build()
        ]

        XCTAssertEqual(result, expectation)
    }
}
