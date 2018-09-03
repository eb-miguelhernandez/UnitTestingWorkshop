//
//  AppDelegate.swift
//  UnitTestingWorkshop
//
//  Created by Miguel Hernández Jaso on 31/08/2018.
//  Copyright © 2018 Eventbrite. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let ticketsVC = TicketsViewController()
        ticketsVC.viewData = self.fakeData()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ticketsVC
        self.window?.makeKeyAndVisible()

        return true
    }

    private func fakeData() -> TicketsViewController.ViewData {
        func getTickets(quantity: Int) -> [Ticket] {
            return (0..<quantity).map { return Ticket(identifier: String($0)) }
        }
        return TicketsViewController.ViewData(ticketCollection: getTickets(quantity: 40))
    }
}

