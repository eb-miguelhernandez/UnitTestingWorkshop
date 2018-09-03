import UIKit

class TicketsViewController: UIViewController {
    @IBOutlet weak var ticketsTableView: UITableView!
    private var ticketsViewControllerTableViewDatasource: TicketsViewControllerTableViewDatasource!

    struct ViewData {
        let title: String
        let ticketQRs: [String]
    }

    var viewData: ViewData? {
        didSet {
            self.title = self.viewData?.title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let tickets = viewData?.ticketQRs {
            let tableViewDatasource = TicketsViewControllerTableViewDatasource(items: tickets)
            self.ticketsTableView.dataSource = tableViewDatasource
        }
    }
}

class TicketsViewControllerTableViewDatasource: NSObject, UITableViewDataSource {
    var items = [String]()
    let date: Date
    let timeZone: TimeZone
    private var dateFormatter: DateFormatter

    init(items: [String], date: Date = Date(), timeZone: TimeZone = TimeZone.current, dateDisplay: DateDisplay = DateDisplay.shortDate) {
        self.items = items
        self.date = date
        self.timeZone = timeZone
        self.dateFormatter = dateDisplay.formatter(forTimeZone: self.timeZone)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRect.zero)
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DateDisplay.text(date: self.date, dateFormatter: self.dateFormatter, timeZone: self.timeZone)
    }
}

extension TicketsViewController.ViewData {
    init(ticketCollection: [Ticket], title: String =  NSLocalizedString("Tickets", comment: "Title for Tickets Screen")) {
        self.title = title
        self.ticketQRs = ticketCollection.map { $0.identifier }
    }
}

struct Ticket {
    let identifier: String
}
