@testable import MVVMArchitectureTemplate
import SwiftUI
import XCTest

@MainActor
final class SampleDetailViewModelTest: XCTestCase {
    private var router: SampleDetailRouterInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleDetailViewModel!
    private var event: FAEvent!

    override func setUp() {
        super.setUp()

        router = .init()
        analytics = .init(screenId: .sampleDetail)

        analytics.sendEventFAEventHandler = { event in
            self.event = event
        }

        viewModel = .init(
            modelObject: SampleModelObjectBuilder().build(),
            router: router,
            analytics: analytics
        )
    }

    func test_ViewModel初期化_FA_screenViewイベントを送信できること() {
        XCTAssertEqual(
            event,
            .screenView
        )
    }

    func test_showEditView_viewModelが保持しているmodelObjectを参照していること() {
        router.routeToEditHandler = { modelObject in
            // assert
            XCTAssertEqual(
                modelObject,
                self.viewModel.modelObject
            )

            return NavigationView {
                SampleEditView(modelObject: modelObject)
            }
        }

        // act
        _ = viewModel.showEditView()
    }
}
