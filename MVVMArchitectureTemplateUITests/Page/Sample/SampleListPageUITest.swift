import XCTest

final class SampleListPageUITest: XCTestCase {
    private var app: XCUIApplication!
    private var page: SampleListPage!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = .init()
        page = .init(app: app)

        app.launch()
    }

    func test_サンプル一覧_追加ボタンが表示されていること() {
        XCTAssertTrue(page.exist)
        XCTAssertTrue(
            page.existElements(
                [page.addButton],
                timeout: 2.0
            )
        )
    }
}
