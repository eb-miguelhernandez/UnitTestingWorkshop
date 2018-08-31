import UIKit

class TicketsViewController: UIViewController {
    @IBOutlet weak var ticketsTableView: UITableView!

    struct ViewData {
        let title: String
        let ticketQRs: [String]
    }

    var viewData: ViewData? {
        didSet {
            self.title = self.viewData?.title
        }
    }
}

extension TicketsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewData?.ticketQRs.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRect.zero)
    }
}

extension TicketsViewController.ViewData {
    init(ticketCollection: [Ticket], title: String = "Tickets") {
        self.title = title
        self.ticketQRs = ticketCollection.map { $0.identifier }
    }
}

struct Ticket {
    let identifier: String
}
