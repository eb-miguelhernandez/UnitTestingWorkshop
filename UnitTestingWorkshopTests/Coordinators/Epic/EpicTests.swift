import XCTest
@testable import UnitTestingWorkshop

class EpicTests: XCTestCase {
    func testAppLaunchEpic() {
        let operations: [EpicOperation] = [
            EpicOperation("app.dismiss_current_modal", block: nil),
            EpicOperation("app.open.safari_vc", block: nil)
        ]
        let epic = Epic(operations: operations)
        var epicIterator = epic.iterator()

        XCTAssertEqual(epicIterator.next()?.identifier, "app.dismiss_current_modal")
        XCTAssertEqual(epicIterator.next()?.identifier, "app.open.safari_vc")
        XCTAssertNil(epicIterator.next()) // Operations are finished
    }
}
