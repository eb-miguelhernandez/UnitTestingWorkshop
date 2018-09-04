import UIKit
import SafariServices
import Epic

class Coordinator {}

class AppCoordinator: Coordinator {
    let mainWindow: UIWindow
    var navVC: UINavigationController
    var currentVC: UIViewController?

    init(mainWindow: UIWindow) {
        self.navVC = UINavigationController()
        self.mainWindow = mainWindow

        super.init()
    }

    func start() {
        let ticketsVC = TicketsViewController()
        self.currentVC = ticketsVC
        self.mainWindow.rootViewController = self.navVC
        self.mainWindow.makeKeyAndVisible()

        let initialOperations = [
            Action.fetchTickets(ticketsVC: ticketsVC, fetchDataService: TicketService.fetchTicketsData),
            Action.openViewController(navVC: self.navVC, vc: ticketsVC),
            // Action.openSafari(url: URL(string: "https://www.eventbrite.com")!, presenter: self.currentVC!) // Uncomment for execution
        ]
        let epic = Epic(operations: initialOperations)
        _ = epic.run()
    }
}

/**
 * Step by step mode
 */
//let initialOperations = [
//    Action.fetchTickets(ticketsVC: ticketsVC, fetchDataService: TicketService.fetchTicketsData),
//    Action.openViewController(navVC: self.navVC, vc: ticketsVC),
//]
//let epic = Epic(operations: initialOperations)
//var iterator = epic.iterator()
//iterator.next(executingBlock: true)
//iterator.next(executingBlock: true)
//iterator.next(executingBlock: true)
