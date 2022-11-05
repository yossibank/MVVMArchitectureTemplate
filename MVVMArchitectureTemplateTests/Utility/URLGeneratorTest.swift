@testable import MVVMArchitectureTemplate
import XCTest

final class URLGeneratorTest: XCTestCase {
    private var urlGenerator: URLGenerator!

    func test_有効なURLを受け取ったGeneratorで生成したURLが有効であること() {
        // arrange
        let url = URL(string: "https://test.com")

        // act
        setupGenerator(urlType: .url(url))

        // assert
        XCTAssertNotNil(urlGenerator.url())
        XCTAssertEqual(urlGenerator.url(), url)
    }

    func test_無効なURLを受け取ったGeneratorで生成したURLがnilであること() {
        // arrange
        let url = URL(string: "不正URL")

        // act
        setupGenerator(urlType: .url(url))

        // assert
        XCTAssertNil(urlGenerator.url())
    }

    func test_有効なURL文字列を受け取ったGeneratorで生成したURLが有効であること() {
        // arrange
        let string = "https://test.com"

        // act
        setupGenerator(urlType: .urlString(string))

        // assert
        XCTAssertNotNil(urlGenerator.url())
        XCTAssertEqual(urlGenerator.url(), URL(string: string))
    }

    func test_無効なURL文字列を受け取ったGeneratorで生成したURLがnilであること() {
        // arrange
        let string = "不正URL"

        // act
        setupGenerator(urlType: .urlString(string))

        // assert
        XCTAssertNil(urlGenerator.url())
    }

    func test_URLにqueryを付与した後のURLを返却できること() {
        // arrange
        let url = URL(string: "https://test.com")
        let queryItems = [URLQueryItem(name: "test", value: "value")]

        setupGenerator(urlType: .url(url))

        // act
        let queryUrl = urlGenerator.queryUrl(queryItems: queryItems)

        // assert
        XCTAssertEqual(
            queryUrl,
            .init(string: "https://test.com?test=value")
        )
    }

    func test_URLにqueryを付与するURLが無効の際にnilを返すこと() {
        // arrange
        let url = URL(string: "不正URL")
        let queryItems = [URLQueryItem(name: "test", value: "value")]

        setupGenerator(urlType: .url(url))

        // act
        let queryUrl = urlGenerator.queryUrl(queryItems: queryItems)

        // assert
        XCTAssertNil(queryUrl)
    }
}

private extension URLGeneratorTest {
    func setupGenerator(urlType: URLType) {
        urlGenerator = .init(urlType: urlType)
    }
}
