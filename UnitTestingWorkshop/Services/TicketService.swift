class Service {}

class TicketService: Service {
    static func fetchTicketsData() -> TicketsViewController.ViewData {
        func getTickets(quantity: Int) -> [Ticket] {
            return (0..<quantity).map { return Ticket(identifier: String($0)) }
        }
        return TicketsViewController.ViewData(ticketCollection: getTickets(quantity: 40))
    }
}
