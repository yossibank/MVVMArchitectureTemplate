import Foundation
@testable import MVVMArchitectureTemplate
import XCTest

class SampleTest: XCTestCase {
    var sample1: Sample1!
    var sample2: Sample2!
    var sample3: Sample3!

    override func setUp() {
        super.setUp()

        sample1 = .init()
        sample2 = .init()
        sample3 = .init()
    }

    func test_sample_hogehoge() {
        XCTAssertEqual(sample1.hogehoge(), "HOGEHOGE")
    }

    func test_sample_foobar() {
        XCTAssertEqual(sample2.foobar(), "FOOBAR")
    }
}
