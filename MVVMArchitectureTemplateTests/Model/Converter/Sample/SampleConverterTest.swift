@testable import MVVMArchitectureTemplate
import XCTest

final class SampleConverterTest: XCTestCase {
    func test_SampleDataObjectをSampleModelObjectに変換できること() {
        // arrange
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

        // assert
        XCTAssertEqual(result, expectation)
    }

    func test_SampleDataObjectをデフォルト値でSampleModelObjectに変換できること() {
        // arrange
        let result = SampleConverter().convert(
            SampleDataObjectBuilder().build()
        )

        let expectation = SampleModelObjectBuilder().build()

        // assert
        XCTAssertEqual(result, expectation)
    }

    func test_配列SampleDataOjbectを配列SampleModelObjectに変換できること() {
        // arrange
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

        // assert
        XCTAssertEqual(result, expectation)
    }

    func test_配列SampleDataOjbectをデフォルト値で配列SampleModelObjectに変換できること() {
        // arrange
        let result = SampleConverter().convert(
            [SampleDataObjectBuilder().build()]
        )

        let expectation = [SampleModelObjectBuilder().build()]

        // assert
        XCTAssertEqual(result, expectation)
    }
}
