@testable import MVVMArchitectureTemplate
import SwiftUI
import XCTest

@MainActor
final class SampleDetailViewModelTest: XCTestCase {
    private var analytics: FirebaseAnalyzableMock!
    private var viewModel: SampleDetailViewModel!

    override func setUp() {
        super.setUp()

        analytics = .init(screenId: .sampleDetail)
        viewModel = .init(
            state: .init(modelObject: SampleModelObjectBuilder().build()),
            dependency: .init(analytics: analytics)
        )
    }

    func test_initialize() {
        // assert
        XCTAssertEqual(
            analytics.sendEventFAEventCallCount,
            1
        )
    }

    func test_initialize_state() {
        // assert
        XCTAssertEqual(
            viewModel.state.modelObject,
            SampleModelObjectBuilder().build()
        )
    }
}
