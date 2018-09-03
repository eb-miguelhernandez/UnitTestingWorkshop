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

    init(items: [String], date: Date = Date()) {
        self.items = items
        self.date = date
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
    public static func getDateFormatter(timeZone: TimeZone?) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy"
        dateFormatter.timeZone = timeZone
        return dateFormatter
    }
    func dateTextForTickets(date: Date, dateFormatter: DateFormatter, timeZone: TimeZone) -> String {
        return dateFormatter.string(from: date)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let timeZone = TimeZone.current
        let dateFormatter = TicketsViewControllerTableViewDatasource.getDateFormatter(timeZone: timeZone)
        return self.dateTextForTickets(date: self.date, dateFormatter: dateFormatter, timeZone: timeZone)
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
