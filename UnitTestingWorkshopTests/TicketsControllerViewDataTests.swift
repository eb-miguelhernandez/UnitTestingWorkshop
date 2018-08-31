import XCTest
@testable import UnitTestingWorkshop

class TicketsControllerViewDataTests: XCTestCase {
    func testDataModelIsCorrect() {
        let tickets = self.tickets(quantity: 3)

        let sut = TicketsViewController.ViewData(ticketCollection: tickets)

        XCTAssertEqual(sut.ticketQRs.count, 3)
        XCTAssertEqual(sut.ticketQRs[0], "0")
        XCTAssertEqual(sut.ticketQRs[2], "2")
    }

    func tickets(quantity: Int) -> [Ticket] {
        return (0..<quantity).map { return Ticket(identifier: String($0)) }
    }
}
