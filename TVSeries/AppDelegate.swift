//
//  AppDelegate.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 21/12/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let viewController = TVSeriesViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        return true
    }
}
