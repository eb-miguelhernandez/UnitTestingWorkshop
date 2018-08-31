import XCTest
@testable import UnitTestingWorkshop

class TicketsViewControllerTest: XCTestCase {
    func getViewData(withTitle title: String = "Tickets title", numberOfTickets: Int = 3) -> TicketsViewController.ViewData {
        func tickets(quantity: Int) -> [Ticket] {
            return (0..<quantity).map { return Ticket(identifier: String($0)) }
        }
        return TicketsViewController.ViewData(ticketCollection: tickets(quantity: numberOfTickets), title: title)
    }
}

class TicketsViewControllerTests: TicketsViewControllerTest {
    var sut: TicketsViewController!
    override func setUp() {
        super.setUp()
        self.sut = TicketsViewController()
    }
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }

    func testTicketsVCDisplaysDataCorrectly() {
        sut.viewData = getViewData(withTitle: "Tickets title")

        XCTAssertNotNil(sut.view)
        XCTAssertNotNil(sut.ticketsTableView)
        XCTAssertEqual(sut.title, "Tickets title")
    }
}

class TicketsViewControllerTableViewTests: TicketsViewControllerTest {
    var sut: UITableView!
    override func setUp() {
        super.setUp()
        self.sut = UITableView()
    }
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }

    func testTicketsVCTableViewDisplays4Items() {
        let viewData = getViewData(numberOfTickets: 4)
        let ticketsDatasource = TicketsViewControllerTableViewDatasource(items: viewData.ticketQRs)

        XCTAssertEqual(ticketsDatasource.numberOfSections(in: self.sut), 1)
        XCTAssertEqual(ticketsDatasource.tableView(self.sut, numberOfRowsInSection: 0), 4)
    }

    func testTicketsVCTableViewDisplaysTheProperQROnCell() {
        let viewData = getViewData(numberOfTickets: 1)
        let ticketsDatasource = TicketsViewControllerTableViewDatasource(items: viewData.ticketQRs)

        let cell = ticketsDatasource.tableView(self.sut, cellForRowAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, viewData.ticketQRs[0])
    }
}
