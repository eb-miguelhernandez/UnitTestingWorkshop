// Actions
extension AppCoordinator {
    enum ActionType: String {
        case fetchTickets = "app.fetch.tickets"
        case openViewController = "app.open.current_vc"
        case openSafari = "app.open.safari_vc"
        case dissmisCurrentModal = "app.dismiss.current_modal"

        var name: String { return self.rawValue }
    }
}
