@testable import MVVMArchitectureTemplate
import XCTest

final class SampleDetailViewModelTest: XCTestCase {
    private var router: SampleDetailRouterInputMock!
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleDetailViewModel!

    override func setUp() {
        super.setUp()

        router = .init()
        analytics = .init(screenId: .sampleDetail)
        viewModel = .init(
            router: router,
            modelObject: SampleModelObjectBuilder().build(),
            analytics: analytics
        )
    }

    func test_input_onAppear_FA_screenViewイベントを送信できていること() {
        // arrange
        let expectation = XCTestExpectation(description: #function)

        analytics.sendEventFAEventHandler = { event in
            // assert
            XCTAssertEqual(event, .screenView)
            expectation.fulfill()
        }

        // act
        viewModel.input.onAppear.send(())

        wait(for: [expectation], timeout: 0.1)
    }
}
