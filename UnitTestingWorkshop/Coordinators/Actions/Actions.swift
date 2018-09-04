import Epic
import UIKit
import SafariServices

// Actions
extension AppCoordinator {
    struct Action {
        static func fetchTickets(ticketsVC: TicketsViewController,
                                 fetchDataService: @escaping () -> TicketsViewController.ViewData) -> EpicOperation {

            return EpicOperation(ActionType.fetchTickets.name) {
                ticketsVC.viewData = fetchDataService()
            }
        }
        static func openViewController(navVC: UINavigationController,
                                       vc: UIViewController) -> EpicOperation {

            return EpicOperation(ActionType.openViewController.name) {
                navVC.pushViewController(vc, animated: true)
            }
        }
        static func openSafari(url: URL,
                               presenter: UIViewController) -> EpicOperation {

            return EpicOperation(ActionType.openSafari.name) {
                let safariVC = SFSafariViewController(url: url)
                presenter.present(safariVC, animated: true, completion: nil)
            }
        }
    }
}
