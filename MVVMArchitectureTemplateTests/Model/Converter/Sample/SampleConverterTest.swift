@testable import MVVMArchitectureTemplate
import XCTest

final class SampleConverterTest: XCTestCase {
    func test_SampleDataObjectをSampleModelObjectに変換できること() {
        // arrange
        let input = SampleDataObjectBuilder()
            .userId(1)
            .id(1)
            .title("title")
            .body("body")
            .build()

        // act
        let actual = SampleConverter().convert(input)

        // assert
        XCTAssertEqual(
            actual,
            SampleModelObjectBuilder()
                .userId(1)
                .id(1)
                .title("title")
                .body("body")
                .build()
        )
    }

    func test_SampleDataObjectをデフォルト値でSampleModelObjectに変換できること() {
        // arrange
        let input = SampleDataObjectBuilder().build()

        // act
        let actual = SampleConverter().convert(input)

        // assert
        XCTAssertEqual(
            actual,
            SampleModelObjectBuilder().build()
        )
    }

    func test_配列SampleDataOjbectを配列SampleModelObjectに変換できること() {
        // arrange
        let input = [
            SampleDataObjectBuilder()
                .userId(1)
                .id(1)
                .title("title")
                .body("body")
                .build()
        ]

        // act
        let actual = SampleConverter().convert(input)

        // assert
        XCTAssertEqual(
            actual,
            [
                SampleModelObjectBuilder()
                    .userId(1)
                    .id(1)
                    .title("title")
                    .body("body")
                    .build()
            ]
        )
    }

    func test_配列SampleDataOjbectをデフォルト値で配列SampleModelObjectに変換できること() {
        // arrange
        let input = [SampleDataObjectBuilder().build()]

        // act
        let actual = SampleConverter().convert(input)

        // assert
        XCTAssertEqual(
            actual,
            [SampleModelObjectBuilder().build()]
        )
    }
}
