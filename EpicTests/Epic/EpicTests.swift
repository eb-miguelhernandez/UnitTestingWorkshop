import XCTest
import Epic

class EpicTests: XCTestCase {
    func testAppLaunchEpic() {
        let operations: [EpicOperation] = [
            EpicOperation("app.dismiss_current_modal", block: nil),
            EpicOperation("app.open.safari_vc", block: nil),
        ]
        let epic = Epic(operations: operations)
        var epicIterator = epic.iterator()

        XCTAssertEqual(epicIterator.next()?.identifier, "app.dismiss_current_modal")
        XCTAssertEqual(epicIterator.next()?.identifier, "app.open.safari_vc")
        XCTAssertTrue(epicIterator.finished) // Operations are finished
    }

    func testRunEpic() {
        let operations: [EpicOperation] = [
            EpicOperation("app.dismiss_current_modal", block: nil),
            EpicOperation("app.open.safari_vc", block: nil),
            ]
        let epic = Epic(operations: operations)

        let epicIterator = epic.run()
        XCTAssertEqual(epicIterator.lastIndex, 2)
        XCTAssertTrue(epicIterator.finished) // Operations are finished
    }
}
