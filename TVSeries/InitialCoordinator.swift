//
//  InitialCoordinator.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 23/12/21.
//

import UIKit
import LocalAuthentication

class InitialCoordinator {
    weak var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func startApp() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authenticateWithBiometric(context: context)
        } else {
            goToTVSeriesViewController()
        }
    }
    
    func authenticateWithBiometric(context: LAContext) {
        let splashScreen = SplashScreenViewController()
        splashScreen.delegate = self
        window?.rootViewController = splashScreen
        let reason = "Please authorize with biometric"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: reason) { success, error in
            DispatchQueue.main.async {
                if success {
                    self.goToTVSeriesViewController()
                } else if let error = error, error._code == LAError.biometryNotAvailable.rawValue {
                    self.goToTVSeriesViewController()
                } else {
                    splashScreen.presentDecision(message: "Failed to authenticate. Try again?", yes: { _ in
                        self.authenticateWithBiometric(context: context)
                    })
                    return
                }
            }
        }
    }
    
    func goToTVSeriesViewController() {
        let tabBarController = UITabBarController()
        
        let tvSeriesViewController = TVSeriesViewController()
        let tvSeriesNavigationController = UINavigationController(rootViewController: tvSeriesViewController)
        tvSeriesNavigationController.tabBarItem.image = UIImage(systemName: "tv.fill")
        
        let favoriteViewController = FavoriteListViewController(viewModel: FavoriteListViewModel())
        let favoriteNavigationController = UINavigationController(rootViewController: favoriteViewController)
        favoriteNavigationController.tabBarItem.image = UIImage(systemName: "star.fill")
        
        tabBarController.viewControllers = [tvSeriesNavigationController, favoriteNavigationController]
        window?.rootViewController = tabBarController
    }
}

extension InitialCoordinator: SplashScreenViewControllerDelegate {
    func didAskToAuthenticate() {
        let context = LAContext()
        self.authenticateWithBiometric(context: context)
    }
}
