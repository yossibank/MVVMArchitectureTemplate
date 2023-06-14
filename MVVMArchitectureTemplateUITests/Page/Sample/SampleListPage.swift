import XCTest

final class SampleListPage: PageObjectable {
    enum Ally {
        static let title = "サンプル一覧"
        static let addButton = "add_button"
    }

    var pageTitle: XCUIElement {
        app.navigationBars[Ally.title].firstMatch
    }

    var addButton: XCUIElement {
        app.buttons[Ally.addButton].firstMatch
    }

    var app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }
}
