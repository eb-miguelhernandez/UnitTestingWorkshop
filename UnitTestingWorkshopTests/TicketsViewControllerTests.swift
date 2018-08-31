import XCTest
@testable import UnitTestingWorkshop

class TicketsViewControllerTests: XCTestCase {
    func testTicketsVCDisplaysDataCorrectly() {
        let sut = TicketsViewController()
        let tickets = self.tickets(quantity: 3)
        let viewData = TicketsViewController.ViewData(ticketCollection: tickets, title: "Tickets title")
        sut.viewData = viewData
        _ = sut.view

        XCTAssertNotNil(sut.view)
        XCTAssertEqual(sut.title, "Tickets title")
        XCTAssertEqual(sut.ticketsTableView.datasource, sut)
    }

    func tickets(quantity: Int) -> [Ticket] {
        return (0..<quantity).map { return Ticket(identifier: String($0)) }
    }
}
